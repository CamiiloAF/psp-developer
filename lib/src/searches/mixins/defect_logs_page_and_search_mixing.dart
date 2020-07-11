import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psp_developer/src/models/defect_logs_model.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_log_edit_page.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/utils.dart' as utils;
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin DefectLogsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, DefectLogModel defectLog,
      {Function closeSearch}) {
    final isEnable = (Preferences().pendingInterruptionStartAt == null);

    return CustomListTile(
      title: 'id: ${defectLog.id}',
      isEnable: isEnable,
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        if (closeSearch != null) closeSearch();
        navigateToEditPage(context, defectLog, defectLog.programsId);
      },
      subtitle: defectLog.description,
    );
  }

  void navigateToEditPage(
      BuildContext context, DefectLogModel defectLog, int programId) {
    final pageToNavigate = DefectLogEditPage(
      programId: programId,
      defectLog: defectLog,
    );

    utils.navigatorPush(context, pageToNavigate);
  }
}
