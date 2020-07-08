import 'package:http/http.dart' as http;
import 'package:psp_developer/src/models/defect_logs_model.dart';
import 'package:psp_developer/src/providers/db_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/insert_and_update_bound_resource.dart';
import 'package:psp_developer/src/utils/network_bound_resources/network_bound_resource.dart';
import 'package:psp_developer/src/utils/rate_limiter.dart';
import 'package:tuple/tuple.dart';

class DefectLogsRepository {
  Future<Tuple2<int, List<DefectLogModel>>> getAllDefectLogs(
      bool isRefresing, int programId) async {
    final networkBoundResource =
        _DefectLogsNetworkBoundResource(RateLimiter(), programId);
    final response = await networkBoundResource.execute(isRefresing);

    if (response.item2 == null) {
      return Tuple2(response.item1, []);
    } else {
      return response;
    }
  }

  Future<Tuple2<int, DefectLogModel>> insertDefectLog(
      DefectLogModel defectLog) async {
    final url = '${Constants.baseUrl}/defect-logs';

    return await _DefectLogsInsertBoundResource()
        .executeInsert(defectLogsModelToJson(defectLog), url);
  }

  Future<int> updateDefectLog(DefectLogModel defectLog) async {
    final url = '${Constants.baseUrl}/defect-logs/${defectLog.id}';
    return await _DefectLogsUpdateBoundResource()
        .executeUpdate(defectLogsModelToJson(defectLog), defectLog, url);
  }
}

class _DefectLogsNetworkBoundResource
    extends NetworkBoundResource<List<DefectLogModel>> {
  final RateLimiter rateLimiter;
  final int programId;

  final tableName = Constants.DEFECT_LOGS_TABLE_NAME;
  final _allDefectLogs = 'allDefectLogs';

  _DefectLogsNetworkBoundResource(this.rateLimiter, this.programId);

  @override
  Future<http.Response> createCall() async {
    final url = '${Constants.baseUrl}/defect-logs/by-program/$programId';

    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  Future saveCallResult(List<DefectLogModel> item) async {
    await DBProvider.db.deleteAll(tableName);

    if (item != null && item.isNotEmpty) {
      await DBProvider.db.insertList(item, tableName);
    }
  }

  @override
  bool shouldFetch(List<DefectLogModel> data) =>
      data == null ||
      data.isEmpty ||
      rateLimiter.shouldFetch(_allDefectLogs, Duration(minutes: 10));

  @override
  Future<List<DefectLogModel>> loadFromDb() async =>
      _getDefectLogsFromJson(await DBProvider.db.getAllModelsByProgramId(
          Constants.DEFECT_LOGS_TABLE_NAME, programId));

  List<DefectLogModel> _getDefectLogsFromJson(List<Map<String, dynamic>> res) {
    return res.isNotEmpty
        ? res.map((defectLog) => DefectLogModel.fromJson(defectLog)).toList()
        : [];
  }

  @override
  void onFetchFailed() {
    rateLimiter.reset(_allDefectLogs);
  }

  @override
  List<DefectLogModel> decodeData(List<dynamic> payload) =>
      DefectLogsModel.fromJsonList(payload).defectLogs;
}

class _DefectLogsInsertBoundResource
    extends InsertAndUpdateBoundResource<DefectLogModel> {
  @override
  DefectLogModel buildNewModel(payload) => DefectLogModel.fromJson(payload);

  @override
  void doOperationInDb(DefectLogModel model) async =>
      await DBProvider.db.insert(model, Constants.DEFECT_LOGS_TABLE_NAME);
}

class _DefectLogsUpdateBoundResource
    extends InsertAndUpdateBoundResource<DefectLogModel> {
  @override
  DefectLogModel buildNewModel(payload) => null;

  @override
  void doOperationInDb(DefectLogModel model) async =>
      await DBProvider.db.update(model, Constants.DEFECT_LOGS_TABLE_NAME);
}
