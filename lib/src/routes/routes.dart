import 'package:flutter/cupertino.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_logs_page.dart';
import 'package:psp_developer/src/pages/login_page.dart';
import 'package:psp_developer/src/pages/modules/modules_page.dart';
import 'package:psp_developer/src/pages/programs/programs_page.dart';
import 'package:psp_developer/src/pages/projects/projects_page.dart';
import 'package:psp_developer/src/pages/test_reports/test_reports_page.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() => <String, WidgetBuilder>{
      'login': (BuildContext context) => LoginPage(),
      'projects': (BuildContext context) => ProjectsPage(),
      'modules': (BuildContext context) => ModulesPage(),
      'programs': (BuildContext context) => ProgramsPage(),
      'timeLogs': (BuildContext context) => TimeLogsPage(),
      'defectLogs': (BuildContext context) => DefectLogsPage(),
      'testReports': (BuildContext context) => TestReportsPage(),
    };
