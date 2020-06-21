import 'package:psp_developer/src/blocs/Validators.dart';
import 'package:psp_developer/src/models/test_reports_model.dart';
import 'package:psp_developer/src/repositories/test_reports_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class TestReportsBloc with Validators {
  final _testReportsProvider = TestReportsRepository();

  final _testReportsController =
      BehaviorSubject<Tuple2<int, List<TestReportModel>>>();

  Stream<Tuple2<int, List<TestReportModel>>> get testReportsStream =>
      _testReportsController.stream;

  Tuple2<int, List<TestReportModel>> get lastValueTestReportsController =>
      _testReportsController.value;

  void getTestReports(bool isRefresing, int programId) async {
    final testReportsWithStatusCode =
        await _testReportsProvider.getAllTestReports(isRefresing, programId);
    _testReportsController.sink.add(testReportsWithStatusCode);
  }

  Future<int> insertTestReport(TestReportModel testReport) async {
    final result = await _testReportsProvider.insertTestReport(testReport);
    final statusCode = result.item1;

    if (statusCode == 201) {
      final tempTestReports = lastValueTestReportsController.item2;
      tempTestReports.add(result.item2);
      _testReportsController.sink.add(Tuple2(200, tempTestReports));
    }
    return statusCode;
  }

  Future<int> updateTestReport(TestReportModel testReport) async {
    final statusCode = await _testReportsProvider.updateTestReport(testReport);

    if (statusCode == 204) {
      final tempTestReports = lastValueTestReportsController.item2;
      final indexOfOldTestReport =
          tempTestReports.indexWhere((element) => element.id == testReport.id);
      tempTestReports[indexOfOldTestReport] = testReport;
      _testReportsController.sink.add(Tuple2(200, tempTestReports));
    }
    return statusCode;
  }

  void dispose() {
    _testReportsController.sink.add(null);
  }
}
