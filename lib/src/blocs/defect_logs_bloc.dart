import 'package:psp_developer/src/models/defect_logs_model.dart';
import 'package:psp_developer/src/repositories/defect_logs_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class DefectLogsBloc {
  final _defectLogsProvider = DefectLogsRepository();

  final _defectLogsController =
      BehaviorSubject<Tuple2<int, List<DefectLogModel>>>();

  Stream<Tuple2<int, List<DefectLogModel>>> get defectLogStream =>
      _defectLogsController.stream;

  Tuple2<int, List<DefectLogModel>> get lastValueDefectLogsController =>
      _defectLogsController.value;

  void getDefectLogs(bool isRefresing, int programId) async {
    final defectLogWithStatusCode =
        await _defectLogsProvider.getAllDefectLogs(isRefresing, programId);
    _defectLogsController.sink.add(defectLogWithStatusCode);
  }

  Future<int> insertDefectLog(DefectLogModel defectLog) async {
    final result = await _defectLogsProvider.insertDefectLog(defectLog);
    final statusCode = result.item1;

    if (statusCode == 201) {
      final tempDefectLogs = lastValueDefectLogsController.item2;
      tempDefectLogs.add(result.item2);
      _defectLogsController.sink.add(Tuple2(200, tempDefectLogs));
    }
    return statusCode;
  }

  Future<int> updateDefectLog(DefectLogModel defectLog) async {
    final statusCode = await _defectLogsProvider.updateDefectLog(defectLog);

    if (statusCode == 204) {
      final tempDefectLogs = lastValueDefectLogsController.item2;
      final indexOfOldDefectLog =
          tempDefectLogs.indexWhere((element) => element.id == defectLog.id);
      tempDefectLogs[indexOfOldDefectLog] = defectLog;
      _defectLogsController.sink.add(Tuple2(200, tempDefectLogs));
    }
    return statusCode;
  }

  void dispose() {
    _defectLogsController.sink.add(null);
  }
}
