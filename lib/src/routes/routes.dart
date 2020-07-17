import 'package:flutter/cupertino.dart';
import 'package:psp_developer/src/pages/analysis_tools/analysis_tools_page.dart';
import 'package:psp_developer/src/pages/base_parts/base_part_edit_page.dart';
import 'package:psp_developer/src/pages/base_parts/base_parts_page.dart';
import 'package:psp_developer/src/pages/defect_logs/defect_logs_page.dart';
import 'package:psp_developer/src/pages/experiences/experiences_page.dart';
import 'package:psp_developer/src/pages/login/login_page.dart';
import 'package:psp_developer/src/pages/modules/modules_page.dart';
import 'package:psp_developer/src/pages/new_parts/new_part_edit_page.dart';
import 'package:psp_developer/src/pages/new_parts/new_parts_page.dart';
import 'package:psp_developer/src/pages/pip/pip_page.dart';
import 'package:psp_developer/src/pages/profile/profile_page.dart';
import 'package:psp_developer/src/pages/programs/program_info_page.dart';
import 'package:psp_developer/src/pages/programs/program_planning_time/program_planning_time_page.dart';
import 'package:psp_developer/src/pages/programs/programs_page.dart';
import 'package:psp_developer/src/pages/projects/projects_page.dart';
import 'package:psp_developer/src/pages/reusable_parts/reusable_part_edit_page.dart';
import 'package:psp_developer/src/pages/reusable_parts/reusable_parts_page.dart';
import 'package:psp_developer/src/pages/test_reports/test_reports_page.dart';
import 'package:psp_developer/src/pages/time_logs/time_logs_page.dart';
import 'package:psp_developer/src/pages/settings/settings_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() => <String, WidgetBuilder>{
      LoginPage.ROUTE_NAME: (BuildContext context) => LoginPage(),
      ExperiencesPage.ROUTE_NAME: (BuildContext context) => ExperiencesPage(),
      ProjectsPage.ROUTE_NAME: (BuildContext context) => ProjectsPage(),
      ModulesPage.ROUTE_NAME: (BuildContext context) => ModulesPage(),
      ProgramsPage.ROUTE_NAME: (BuildContext context) => ProgramsPage(),
      ProgramInfoPage.ROUTE_NAME: (BuildContext context) => ProgramInfoPage(),
      ProfilePage.ROUTE_NAME: (BuildContext context) => ProfilePage(),
      SettingsPage.ROUTE_NAME: (BuildContext context) => SettingsPage(),
      TimeLogsPage.ROUTE_NAME: (BuildContext context) => TimeLogsPage(),
      DefectLogsPage.ROUTE_NAME: (BuildContext context) => DefectLogsPage(),
      TestReportsPage.ROUTE_NAME: (BuildContext context) => TestReportsPage(),
      PIPPage.ROUTE_NAME: (BuildContext context) => PIPPage(),
      BasePartsPage.ROUTE_NAME: (BuildContext context) => BasePartsPage(),
      BasePartEditPage.ROUTE_NAME: (BuildContext context) => BasePartEditPage(),
      NewPartsPage.ROUTE_NAME: (BuildContext context) => NewPartsPage(),
      NewPartEditPage.ROUTE_NAME: (BuildContext context) => NewPartEditPage(),
      ReusablePartsPage.ROUTE_NAME: (BuildContext context) =>
          ReusablePartsPage(),
      ReusablePartEditPage.ROUTE_NAME: (BuildContext context) =>
          ReusablePartEditPage(),
      ProgramPlanningTimePage.ROUTE_NAME: (BuildContext context) =>
          ProgramPlanningTimePage(),
      AnalysisToolsPage.ROUTE_NAME: (BuildContext context) =>
          AnalysisToolsPage(),
    };
