import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/test_reports_bloc.dart';
import 'package:psp_developer/src/models/test_reports_model.dart';
import 'package:psp_developer/src/pages/test_reports/test_report_edit_page.dart';
import 'package:psp_developer/src/utils/searchs/search_delegate.dart';
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

class SearchTestReports extends DataSearch {
  final TestReportsBloc _testReportsBloc;
  final int programId;

  SearchTestReports(this._testReportsBloc, this.programId);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return super.textNoResults(context);

    final testReports =
        _testReportsBloc?.lastValueTestReportsController?.item2 ?? [];
    if (testReports.isNotEmpty && testReports != null) {
      return Container(
          child: ListView(
        children: testReports
            .where((testReport) => _areItemContainQuery(testReport, query))
            .map((testReport) {
          return CustomListTile(
            title: testReport.testName,
            trailing:
                Text('${S.of(context).labelNumber} ${testReport.testNumber}'),
            onTap: () => navigateToEditPage(context, testReport),
            subtitle: testReport.objective,
          );
        }).toList(),
      ));
    } else {
      return super.textNoResults(context);
    }
  }

  void navigateToEditPage(BuildContext context, TestReportModel testReport) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => TestReportEditPage(
            programId: programId,
            testReport: testReport,
          ),
        ));
  }

  bool _areItemContainQuery(TestReportModel testReport, String query) {
    return '${testReport.testNumber}'.contains(query.toLowerCase()) ||
            testReport.testName.toLowerCase().contains(query.toLowerCase()) ||
            testReport.objective.toLowerCase().contains(query.toLowerCase())
        ? true
        : false;
  }
}
