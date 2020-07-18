import 'package:http/http.dart' as http;
import 'package:psp_developer/src/models/new_parts_model.dart';
import 'package:psp_developer/src/providers/db_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/insert_and_update_bound_resource.dart';
import 'package:psp_developer/src/utils/network_bound_resources/network_bound_resource.dart';
import 'package:psp_developer/src/utils/rate_limiter.dart';
import 'package:tuple/tuple.dart';

class NewPartsRepository {
  Future<Tuple2<int, List<NewPartModel>>> getAllNewParts(
      bool isRefreshing, int programId) async {
    final networkBoundResource =
        _NewPartsNetworkBoundResource(RateLimiter(), programId);
    final response = await networkBoundResource.execute(isRefreshing);

    return (response.item2 == null) ? Tuple2(response.item1, []) : response;
  }

  Future<int> updateNewPart(NewPartModel newPart) async {
    final url = '${Constants.baseUrl}/new-parts/${newPart.id}';
    return await _NewPartsUpdateBoundResource()
        .executeUpdate(newPartModelToJson(newPart), newPart, url);
  }
}

class _NewPartsNetworkBoundResource
    extends NetworkBoundResource<List<NewPartModel>> {
  final RateLimiter rateLimiter;
  final int programId;

  final tableName = Constants.NEW_PARTS_TABLE_NAME;
  final _allNewParts = 'allNewParts';

  _NewPartsNetworkBoundResource(this.rateLimiter, this.programId);

  @override
  Future<http.Response> createCall() async {
    final url = '${Constants.baseUrl}/new-parts/by-program/$programId';

    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  Future saveCallResult(List<NewPartModel> item) async {
    await DBProvider.db.deleteAll(tableName);

    if (item != null && item.isNotEmpty) {
      await DBProvider.db.insertList(item, tableName);
    }
  }

  @override
  bool shouldFetch(List<NewPartModel> data) =>
      data == null ||
      data.isEmpty ||
      rateLimiter.shouldFetch(_allNewParts, Duration(minutes: 10));

  @override
  Future<List<NewPartModel>> loadFromLocalStorage() async =>
      _getNewPartsFromJson(await DBProvider.db
          .getAllModelsByProgramId(Constants.NEW_PARTS_TABLE_NAME, programId));

  List<NewPartModel> _getNewPartsFromJson(List<Map<String, dynamic>> res) {
    return res.isNotEmpty
        ? res.map((newPart) => NewPartModel.fromJson(newPart)).toList()
        : [];
  }

  @override
  void onFetchFailed() => rateLimiter.reset(_allNewParts);

  @override
  List<NewPartModel> decodeData(List<dynamic> payload) =>
      NewPartsModel.fromJsonList(payload).newParts;
}

class _NewPartsUpdateBoundResource
    extends InsertAndUpdateBoundResource<NewPartModel> {
  @override
  NewPartModel buildNewModel(payload) => null;

  @override
  void doOperationInDb(NewPartModel model) async =>
      await DBProvider.db.update(model, Constants.NEW_PARTS_TABLE_NAME);
}
