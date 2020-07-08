import 'package:http/http.dart' as http;
import 'package:psp_developer/src/models/time_logs_model.dart';
import 'package:psp_developer/src/providers/db_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/insert_and_update_bound_resource.dart';
import 'package:psp_developer/src/utils/network_bound_resources/network_bound_resource.dart';
import 'package:psp_developer/src/utils/rate_limiter.dart';
import 'package:tuple/tuple.dart';

class TimeLogsRepository {
  Future<Tuple2<int, List<TimeLogModel>>> getAllTimeLogs(
      bool isRefresing, int programId) async {
    final networkBoundResource =
        _TimeLogsNetworkBoundResource(RateLimiter(), programId);
    final response = await networkBoundResource.execute(isRefresing);

    if (response.item2 == null) {
      return Tuple2(response.item1, []);
    } else {
      return response;
    }
  }

  Future<Tuple2<int, TimeLogModel>> insertTimeLog(TimeLogModel timeLog) async {
    final url = '${Constants.baseUrl}/time-logs';

    return await _TimeLogsInsertBoundResource()
        .executeInsert(timeLogModelToJson(timeLog), url);
  }

  Future<int> updateTimeLog(TimeLogModel timeLog) async {
    final url = '${Constants.baseUrl}/time-logs/${timeLog.id}';
    return await _TimeLogsUpdateBoundResource()
        .executeUpdate(timeLogModelToJson(timeLog), timeLog, url);
  }
}

class _TimeLogsNetworkBoundResource
    extends NetworkBoundResource<List<TimeLogModel>> {
  final RateLimiter rateLimiter;
  final int programId;

  final tableName = Constants.TIME_LOGS_TABLE_NAME;
  final _allTimeLogs = 'allTimeLogs';

  _TimeLogsNetworkBoundResource(this.rateLimiter, this.programId);

  @override
  Future<http.Response> createCall() async {
    final url = '${Constants.baseUrl}/time-logs/by-program/$programId';

    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  Future saveCallResult(List<TimeLogModel> item) async {
    await DBProvider.db.deleteAll(tableName);

    if (item != null && item.isNotEmpty) {
      await DBProvider.db.insertList(item, tableName);
    }
  }

  @override
  bool shouldFetch(List<TimeLogModel> data) =>
      data == null ||
      data.isEmpty ||
      rateLimiter.shouldFetch(_allTimeLogs, Duration(minutes: 10));

  @override
  Future<List<TimeLogModel>> loadFromDb() async =>
      _getTimeLogsFromJson(await DBProvider.db
          .getAllModelsByProgramId(Constants.TIME_LOGS_TABLE_NAME, programId));

  List<TimeLogModel> _getTimeLogsFromJson(List<Map<String, dynamic>> res) {
    return res.isNotEmpty
        ? res.map((timeLog) => TimeLogModel.fromJson(timeLog)).toList()
        : [];
  }

  @override
  void onFetchFailed() {
    rateLimiter.reset(_allTimeLogs);
  }

  @override
  List<TimeLogModel> decodeData(List<dynamic> payload) =>
      TimeLogsModel.fromJsonList(payload).timeLogs;
}

class _TimeLogsInsertBoundResource
    extends InsertAndUpdateBoundResource<TimeLogModel> {
  @override
  TimeLogModel buildNewModel(payload) => TimeLogModel.fromJson(payload);

  @override
  void doOperationInDb(TimeLogModel model) async =>
      await DBProvider.db.insert(model, Constants.TIME_LOGS_TABLE_NAME);
}

class _TimeLogsUpdateBoundResource
    extends InsertAndUpdateBoundResource<TimeLogModel> {
  @override
  TimeLogModel buildNewModel(payload) => null;

  @override
  void doOperationInDb(TimeLogModel model) async =>
      await DBProvider.db.update(model, Constants.TIME_LOGS_TABLE_NAME);
}
