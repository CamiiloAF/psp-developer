import 'package:psp_developer/src/models/time_logs_model.dart';
import 'package:psp_developer/src/repositories/time_logs_repository.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class TimeLogsBloc {
  final _timeLogsProvider = TimeLogsRepository();

  final _timeLogsController =
      BehaviorSubject<Tuple2<int, List<TimeLogModel>>>();

  Stream<Tuple2<int, List<TimeLogModel>>> get timeLogsStream =>
      _timeLogsController.stream;

  Tuple2<int, List<TimeLogModel>> get lastValueTimeLogsController =>
      _timeLogsController.value;

  bool allowCreateTimeLog = true;

  void getTimeLogs(bool isRefresing, int programId) async {
    final timeLogWithStatusCode =
        await _timeLogsProvider.getAllTimeLogs(isRefresing, programId);

    verifyIfAllowCreateTimeLogs(timeLogWithStatusCode.item2);

    _timeLogsController.sink.add(timeLogWithStatusCode);
  }

  void verifyIfAllowCreateTimeLogs(List<TimeLogModel> timeLogs) {
    if (!isNullOrEmpty(timeLogs)) {
      for (var timeLog in timeLogs) {
        if (!isAllowCreateNewTimeLog(timeLog.finishDate)) {
          allowCreateTimeLog = false;
          break;
        } else {
          allowCreateTimeLog = true;
        }
      }
      ;
    }
  }

  Future<int> insertTimeLog(TimeLogModel timeLog) async {
    final result = await _timeLogsProvider.insertTimeLog(timeLog);
    final statusCode = result.item1;

    if (statusCode == 201) {
      allowCreateTimeLog = isAllowCreateNewTimeLog(timeLog.finishDate);
      final tempTimeLogs = lastValueTimeLogsController.item2;
      tempTimeLogs.add(result.item2);
      _timeLogsController.sink.add(Tuple2(200, tempTimeLogs));
    }
    return statusCode;
  }

  Future<int> updateTimeLog(TimeLogModel timeLog) async {
    final statusCode = await _timeLogsProvider.updateTimeLog(timeLog);

    if (statusCode == 204) {
      allowCreateTimeLog = isAllowCreateNewTimeLog(timeLog.finishDate);

      final tempTimeLogs = lastValueTimeLogsController.item2;
      final indexOfOldTimeLog =
          tempTimeLogs.indexWhere((element) => element.id == timeLog.id);
      tempTimeLogs[indexOfOldTimeLog] = timeLog;
      _timeLogsController.sink.add(Tuple2(200, tempTimeLogs));
    }
    return statusCode;
  }

  bool isAllowCreateNewTimeLog(int finishDate) => finishDate != null;

  void dispose() => _timeLogsController.sink.add(null);
}
