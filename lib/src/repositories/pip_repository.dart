import 'package:http/http.dart' as http;
import 'package:psp_developer/src/models/pip_model.dart';
import 'package:psp_developer/src/providers/db_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/insert_and_update_bound_resource.dart';
import 'package:psp_developer/src/utils/network_bound_resources/network_bound_resource.dart';
import 'package:psp_developer/src/utils/rate_limiter.dart';
import 'package:tuple/tuple.dart';

class PIPRepository {
  Future<Tuple2<int, PIPModel>> getPIP(bool isRefresing, int programId) async {
    final networkBoundResource =
        _PIPNetworkBoundResource(RateLimiter(), programId);

    final response = await networkBoundResource.execute(isRefresing);

    return (response.item2 == null) ? Tuple2(response.item1, null) : response;
  }

  Future<Tuple2<int, PIPModel>> insertPIP(PIPModel pip) async {
    final url = '${Constants.baseUrl}/pip';

    return await _PIPInsertBoundResource()
        .executeInsert(pipModelToJson(pip), url);
  }

  Future<int> updatePIP(PIPModel pip) async {
    final url = '${Constants.baseUrl}/pip/${pip.id}';
    return await _PIPUpdateBoundResource()
        .executeUpdate(pipModelToJson(pip), pip, url);
  }
}

class _PIPNetworkBoundResource extends NetworkBoundResource<PIPModel> {
  final RateLimiter rateLimiter;
  final int programId;

  final tableName = Constants.PIP_TABLE_NAME;
  final _pipRateLimitKey = 'pip';

  _PIPNetworkBoundResource(this.rateLimiter, this.programId);

  @override
  Future<http.Response> createCall() async {
    final url = '${Constants.baseUrl}/pip/by-program/$programId';
    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  Future saveCallResult(PIPModel item) async {
    await DBProvider.db.deleteAll(tableName);

    if (item != null) {
      await DBProvider.db.insert(item, tableName);
    }
  }

  @override
  bool shouldFetch(PIPModel data) =>
      data == null ||
      rateLimiter.shouldFetch(_pipRateLimitKey, Duration(minutes: 10));

  @override
  Future<PIPModel> loadFromDb() async {
    //Es una lista con un sólo elemento o en su defecto con ninguno
    final pips = await DBProvider.db
        .getAllModelsByProgramId(Constants.PIP_TABLE_NAME, programId);

    return (pips != null && pips.isNotEmpty) ? _getPIPFromJson(pips[0]) : null;
  }

  PIPModel _getPIPFromJson(Map<String, dynamic> res) =>
      res.isNotEmpty ? PIPModel.fromJson(res) : null;

  @override
  void onFetchFailed() {
    rateLimiter.reset(_pipRateLimitKey);
  }

  @override
  PIPModel decodeData(dynamic payload) =>
      (payload != null) ? PIPModel.fromJson(payload) : null;
}

class _PIPInsertBoundResource extends InsertAndUpdateBoundResource<PIPModel> {
  @override
  PIPModel buildNewModel(payload) => PIPModel.fromJson(payload);

  @override
  void doOperationInDb(PIPModel model) async =>
      await DBProvider.db.insert(model, Constants.PIP_TABLE_NAME);
}

class _PIPUpdateBoundResource extends InsertAndUpdateBoundResource<PIPModel> {
  @override
  PIPModel buildNewModel(payload) => null;

  @override
  void doOperationInDb(PIPModel model) async =>
      await DBProvider.db.update(model, Constants.PIP_TABLE_NAME);
}
