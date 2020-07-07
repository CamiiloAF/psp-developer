import 'package:flutter/cupertino.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_logs_page.dart';
import 'package:psp_developer/src/pages/login/login_page.dart';
import 'package:psp_developer/src/pages/modules/modules_page.dart';
import 'package:psp_developer/src/pages/pip/pip_page.dart';
import 'package:psp_developer/src/pages/profile/profile_page.dart';
import 'package:psp_developer/src/pages/programs/programs_page.dart';
import 'package:psp_developer/src/pages/projects/projects_page.dart';
import 'package:psp_developer/src/pages/test_reports/test_reports_page.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() => <String, WidgetBuilder>{
      'login': (BuildContext context) => LoginPage(),
      'projects': (BuildContext context) => ProjectsPage(),
      'modules': (BuildContext context) => ModulesPage(),
      'programs': (BuildContext context) => ProgramsPage(),
      'profile': (BuildContext context) => ProfilePage(),
      TimeLogsPage.ROUTE_NAME: (BuildContext context) => TimeLogsPage(),
      DefectLogsPage.ROUTE_NAME: (BuildContext context) => DefectLogsPage(),
      TestReportsPage.ROUTE_NAME: (BuildContext context) => TestReportsPage(),
      PIPPage.ROUTE_NAME: (BuildContext context) => PIPPage(),
    };
