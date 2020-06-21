import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_logs_page.dart';
import 'package:psp_developer/src/pages/test_reports/test_reports_page.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';
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
                onTap: () =>
                    navigateTo(context, TimeLogsPage(programId: programId))),
            CustomListTile(
                title: S.of(context).appBarTitleDefectLogs,
                onTap: () =>
                    navigateTo(context, DefectLogsPage(programId: programId))),
            CustomListTile(
                title: S.of(context).appBarTitleTestReports,
                onTap: () =>
                    navigateTo(context, TestReportsPage(programId: programId))),
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

  void navigateTo(BuildContext context, dynamic page) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => page));
}
