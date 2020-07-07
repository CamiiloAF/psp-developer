import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/models/test_reports_model.dart';
import 'package:psp_developer/src/pages/test_reports/test_report_edit_page.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/utils.dart' as utils;
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin TestReportsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, TestReportModel testReport,
      {Function closeSearch}) {
    final isEnable = (Preferences().pendingInterruptionStartAt == null);

    return CustomListTile(
      title: testReport.testName,
      trailing: Text('${S.of(context).labelNumber} ${testReport.testNumber}'),
      onTap: () {
        if (closeSearch != null) closeSearch();
        navigateToEditPage(context, testReport, testReport.programsId);
      },
      isEnable: isEnable,
      subtitle: testReport.objective,
    );
  }

  void navigateToEditPage(
      BuildContext context, TestReportModel testReport, int programId) {
    final pageToNavigate = TestReportEditPage(
      programId: programId,
      testReport: testReport,
    );
    utils.navigatorPush(context, pageToNavigate);
  }
}
