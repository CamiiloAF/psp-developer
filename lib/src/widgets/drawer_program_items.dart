import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_logs_page.dart';
import 'package:psp_developer/src/pages/pip/pip_page.dart';
import 'package:psp_developer/src/pages/profile/profile_page.dart';
import 'package:psp_developer/src/pages/test_reports/test_reports_page.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
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
            _buildCircleAvatar(context),
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

  SafeArea _buildCircleAvatar(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        height: 200,
        child: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, ProfilePage.ROUTE_NAME),
            child: Text(
              _getCurrentUserNameInitials(),
              style: TextStyle(fontSize: 50),
            ),
          ),
        ),
      ),
    );
  }

  String _getCurrentUserNameInitials() {
    final currentUser = json.decode(Preferences().curentUser);

    final firstName = currentUser['first_name'].toString().trimLeft();
    final lastName = currentUser['last_name'].toString().trimLeft();

    return '${firstName[0]}${lastName[0]}';
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
