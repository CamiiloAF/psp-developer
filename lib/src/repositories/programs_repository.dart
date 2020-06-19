import 'package:http/http.dart' as http;
import 'package:psp_developer/src/models/programs_model.dart';
import 'package:psp_developer/src/providers/db_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/network_bound_resource.dart';
import 'package:psp_developer/src/utils/rate_limiter.dart';
import 'package:tuple/tuple.dart';

class ProgramsRepository {
  Future<Tuple2<int, List<ProgramModel>>> getAllPrograms(
      bool isRefresing, int moduleId) async {
    final networkBoundResource =
        _ProgramsNetworkBoundResource(RateLimiter(), '$moduleId');

    final response = await networkBoundResource.execute(isRefresing);

    if (response.item2 == null) {
      return Tuple2(response.item1, []);
    } else {
      return response;
    }
  }
}

class _ProgramsNetworkBoundResource
    extends NetworkBoundResource<List<ProgramModel>> {
  final RateLimiter rateLimiter;
  final String moduleId;

  final tableName = Constants.PROGRAMS_TABLE_NAME;
  final _allPrograms = 'allPrograms';

  _ProgramsNetworkBoundResource(this.rateLimiter, this.moduleId);

  @override
  Future<http.Response> createCall() async {
    final url = '${Constants.baseUrl}/programs/by-module/$moduleId';
    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  Future saveCallResult(List<ProgramModel> item) async {
    await DBProvider.db.deleteAllByModuleId(moduleId, tableName);

    if (item != null && item.isNotEmpty) {
      await DBProvider.db.insertList(item, tableName);
    }
  }

  @override
  bool shouldFetch(List<ProgramModel> data) =>
      data == null ||
      data.isEmpty ||
      rateLimiter.shouldFetch(_allPrograms, Duration(minutes: 10));

  @override
  Future<List<ProgramModel>> loadFromDb() async => _getProgramsFromJson(
      await DBProvider.db.getAllProgramsByModuleId(moduleId));

  List<ProgramModel> _getProgramsFromJson(List<Map<String, dynamic>> res) {
    return res.isNotEmpty
        ? res.map((program) => ProgramModel.fromJson(program)).toList()
        : [];
  }

  @override
  void onFetchFailed() {
    rateLimiter.reset(_allPrograms);
  }

  @override
  List<ProgramModel> decodeData(List<dynamic> payload) =>
      ProgramsModel.fromJsonList(payload).programs;
}
