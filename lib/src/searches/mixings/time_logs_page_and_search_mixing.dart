import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/src/models/time_logs_model.dart';
import 'package:psp_developer/src/pages/time_logs/time_log_edit_page.dart';
import 'package:psp_developer/src/providers/models/time_log_pending_interruption.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:psp_developer/src/utils/utils.dart' as utils;
import 'package:psp_developer/src/widgets/custom_list_tile.dart';

mixin TimeLogsPageAndSearchMixing {
  Widget buildItemList(BuildContext context, TimeLogModel timeLog,
      {Function closeSearch}) {
    var isEnabled =
        Provider.of<TimelogPendingInterruptionModel>(context).isListItemsEnable;

    if (!isEnabled &&
        Preferences().timeLogIdWithPendingInterruption == timeLog.id) {
      isEnabled = true;
    }

    return ChangeNotifierProvider(
      create: (_) => TimelogPendingInterruptionModel(),
      child: CustomListTile(
        title: 'id: ${timeLog.id}',
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          if (closeSearch != null) closeSearch();
          navigateToEditPage(context, timeLog, timeLog.programsId);
        },
        isEnable: isEnabled,
        subtitle: Constants.format
            .format(DateTime.fromMillisecondsSinceEpoch(timeLog.startDate)),
      ),
    );
  }

  void navigateToEditPage(
      BuildContext context, TimeLogModel timeLog, int programId) {
    final page = TimeLogEditPage(
      programId: programId,
      timeLog: timeLog,
    );
    utils.navigatorPush(context, page);
  }
}
