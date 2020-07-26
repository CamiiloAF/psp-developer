import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/src/models/defect_logs_model.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_log_edit_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/utils.dart' as utils;
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin DefectLogsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, DefectLogModel defectLog,
      {Function closeSearch}) {
    final programsBloc = Provider.of<BlocProvider>(context).programsBloc;

    var isEnabled = (Preferences().pendingInterruptionStartAt == null);

    if(!isEnabled && programsBloc.getCurrentProgram().deliveryDate != null){
      isEnabled = true;
    }

    return CustomListTile(
      title: 'id: ${defectLog.id}',
      isEnabled: isEnabled,
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
