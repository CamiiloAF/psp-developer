import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_logs_page.dart';
import 'package:psp_developer/src/pages/pip/pip_page.dart';
import 'package:psp_developer/src/pages/test_reports/test_reports_page.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/utils/theme/theme_changer.dart';

import 'custom_list_tile.dart';

class DrawerProgramItems extends StatelessWidget {
  final int programId;

  const DrawerProgramItems({@required this.programId});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  child: Text(
                    'FH',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
            ),
            CustomListTile(
                title: S.of(context).appBarTitleTimeLogs,
                onTap: () => navigateTo(context, TimeLogsPage.ROUTE_NAME)),
            CustomListTile(
                title: S.of(context).appBarTitleDefectLogs,
                onTap: () => navigateTo(context, DefectLogsPage.ROUTE_NAME)),
            CustomListTile(
                title: S.of(context).appBarTitleTestReports,
                onTap: () => navigateTo(context, TestReportsPage.ROUTE_NAME)),
            CustomListTile(
                isEnable: isPIPEnabled(context),
                title: S.of(context).appBarTitlePIP,
                onTap: () => navigateTo(context, PIPPage.ROUTE_NAME)),
            Divider(),
            ListTile(
              leading: Icon(Icons.brightness_4),
              title: Text(S.of(context).darkMode),
              trailing: Switch.adaptive(
                  value: appTheme.isDarkTheme,
                  activeColor: appTheme.currentTheme.accentColor,
                  onChanged: (value) => appTheme.isDarkTheme = value),
            ),
          ],
        ),
      ),
    );
  }

  bool isPIPEnabled(BuildContext context) {
    final lastValueProgramsStream = Provider.of<BlocProvider>(context)
        .programsBloc
        .lastValueProgramsByModuleIdController;

    return lastValueProgramsStream.item2
            .firstWhere((element) => element.id == programId)
            .deliveryDate !=
        null;
  }

  void navigateTo(BuildContext context, String routeName) {
    final currentRouteName = ModalRoute.of(context).settings.name;

    if (currentRouteName == routeName) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, routeName, arguments: programId);
    }
  }
}
