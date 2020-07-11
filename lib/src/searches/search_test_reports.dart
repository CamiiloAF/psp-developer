import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psp_developer/src/blocs/test_reports_bloc.dart';
import 'package:psp_developer/src/models/test_reports_model.dart';
import 'package:psp_developer/src/searches/mixins/test_reports_page_and_search_mixing.dart';
import 'package:psp_developer/src/searches/search_delegate.dart';

class SearchTestReports extends DataSearch with TestReportsPageAndSearchMixing {
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
          return buildItemList(context, testReport,
              closeSearch: () => close(context, null));
        }).toList(),
      ));
    } else {
      return super.textNoResults(context);
    }
  }

  bool _areItemContainQuery(TestReportModel testReport, String query) {
    return '${testReport.testNumber}'.contains(query.toLowerCase()) ||
            testReport.testName.toLowerCase().contains(query.toLowerCase()) ||
            testReport.objective.toLowerCase().contains(query.toLowerCase())
        ? true
        : false;
  }
}
