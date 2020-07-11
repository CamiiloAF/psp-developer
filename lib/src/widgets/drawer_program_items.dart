import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/pages/base_parts/base_parts_page.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_logs_page.dart';
import 'package:psp_developer/src/pages/new_parts/new_parts_page.dart';
import 'package:psp_developer/src/pages/pip/pip_page.dart';
import 'package:psp_developer/src/pages/profile/profile_page.dart';
import 'package:psp_developer/src/pages/reusable_parts/reusable_parts_page.dart';
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
    final s = S.of(context);

    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            _buildCircleAvatar(context),
            CustomListTile(
                title: s.appBarTitleTimeLogs,
                onTap: () => navigateTo(context, TimeLogsPage.ROUTE_NAME)),
            CustomListTile(
                title: s.appBarTitleDefectLogs,
                onTap: () => navigateTo(context, DefectLogsPage.ROUTE_NAME)),
            CustomListTile(
                title: s.appBarTitleTestReports,
                onTap: () => navigateTo(context, TestReportsPage.ROUTE_NAME)),
            CustomListTile(
                isEnable: isPIPEnabled(context),
                title: s.appBarTitlePIP,
                onTap: () => navigateTo(context, PIPPage.ROUTE_NAME)),
            Divider(),
            FadeInLeft(
              child: Container(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 16),
                child: Text(
                  s.appBarTitleProgramParts,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            CustomListTile(
                title: s.appBarTitleBaseParts,
                onTap: () => navigateTo(context, BasePartsPage.ROUTE_NAME)),
            CustomListTile(
                title: s.appBarTitleReusableParts,
                onTap: () => navigateTo(context, ReusablePartsPage.ROUTE_NAME)),
            CustomListTile(
                title: s.appBarTitleNewParts,
                onTap: () => navigateTo(context, NewPartsPage.ROUTE_NAME)),
            Divider(),
            ListTile(
              leading: Icon(Icons.brightness_4),
              title: Text(s.darkMode),
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
        height: 150,
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
