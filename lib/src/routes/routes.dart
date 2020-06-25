import 'package:flutter/cupertino.dart';
import 'package:psp_developer/src/pages/login_page.dart';
import 'package:psp_developer/src/pages/modules/modules_page.dart';
import 'package:psp_developer/src/pages/programs/program_parts/program_parts_page.dart';
import 'package:psp_developer/src/pages/programs/programs_page.dart';
import 'package:psp_developer/src/pages/projects/projects_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() => <String, WidgetBuilder>{
      'login': (BuildContext context) => LoginPage(),
      'projects': (BuildContext context) => ProjectsPage(),
      'modules': (BuildContext context) => ModulesPage(),
      'programs': (BuildContext context) => ProgramsPage(),
      'p': (BuildContext context) => ProgramPartsPage(),
    };
