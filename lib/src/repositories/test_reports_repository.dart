import 'package:http/http.dart' as http;
import 'package:psp_developer/src/models/test_reports_model.dart';
import 'package:psp_developer/src/providers/db_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/network_bound_resources/insert_and_update_bound_resource.dart';
import 'package:psp_developer/src/utils/network_bound_resources/network_bound_resource.dart';
import 'package:psp_developer/src/utils/rate_limiter.dart';
import 'package:tuple/tuple.dart';

class TestReportsRepository {
  Future<Tuple2<int, List<TestReportModel>>> getAllTestReports(
      bool isRefresing, int programId) async {
    final networkBoundResource =
        _TestReportsNetworkBoundResource(RateLimiter(), programId);
    final response = await networkBoundResource.execute(isRefresing);

    if (response.item2 == null) {
      return Tuple2(response.item1, []);
    } else {
      return response;
    }
  }

  Future<Tuple2<int, TestReportModel>> insertTestReport(
      TestReportModel testReport) async {
    final url = '${Constants.baseUrl}/test-reports';

    return await _TestReportsInsertBoundResource()
        .executeInsert(testReportModelToJson(testReport), url);
  }

  Future<int> updateTestReport(TestReportModel testReport) async {
    final url = '${Constants.baseUrl}/test-reports/${testReport.id}';
    return await _TestReportsUpdateBoundResource()
        .executeUpdate(testReportModelToJson(testReport), testReport, url);
  }
}

class _TestReportsNetworkBoundResource
    extends NetworkBoundResource<List<TestReportModel>> {
  final RateLimiter rateLimiter;
  final int programId;

  final tableName = Constants.TEST_REPORTS_TABLE_NAME;
  final _allTestReports = 'allTestReports';

  _TestReportsNetworkBoundResource(this.rateLimiter, this.programId);

  @override
  Future<http.Response> createCall() async {
    final url = '${Constants.baseUrl}/test-reports/by-program/$programId';

    return await http.get(url, headers: Constants.getHeaders());
  }

  @override
  Future saveCallResult(List<TestReportModel> item) async {
    await DBProvider.db.deleteAll(tableName);

    if (item != null && item.isNotEmpty) {
      await DBProvider.db.insertList(item, tableName);
    }
  }

  @override
  bool shouldFetch(List<TestReportModel> data) =>
      data == null ||
      data.isEmpty ||
      rateLimiter.shouldFetch(_allTestReports, Duration(minutes: 10));

  @override
  Future<List<TestReportModel>> loadFromDb() async =>
      _getTestReportsFromJson(await DBProvider.db.getAllModelsByProgramId(
          Constants.TEST_REPORTS_TABLE_NAME, programId));

  List<TestReportModel> _getTestReportsFromJson(
      List<Map<String, dynamic>> res) {
    return res.isNotEmpty
        ? res.map((testReport) => TestReportModel.fromJson(testReport)).toList()
        : [];
  }

  @override
  void onFetchFailed() {
    rateLimiter.reset(_allTestReports);
  }

  @override
  List<TestReportModel> decodeData(List<dynamic> payload) =>
      TestReportsModel.fromJsonList(payload).testReports;
}

class _TestReportsInsertBoundResource
    extends InsertAndUpdateBoundResource<TestReportModel> {
  @override
  TestReportModel buildNewModel(payload) => TestReportModel.fromJson(payload);

  @override
  void doOperationInDb(TestReportModel model) async =>
      await DBProvider.db.insert(model, Constants.TEST_REPORTS_TABLE_NAME);
}

class _TestReportsUpdateBoundResource
    extends InsertAndUpdateBoundResource<TestReportModel> {
  @override
  TestReportModel buildNewModel(payload) => null;

  @override
  void doOperationInDb(TestReportModel model) async =>
      await DBProvider.db.update(model, Constants.TEST_REPORTS_TABLE_NAME);
}
