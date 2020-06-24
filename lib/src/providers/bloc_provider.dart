import 'package:psp_developer/src/blocs/base_parts_bloc.dart';
import 'package:psp_developer/src/blocs/defect_logs_bloc.dart';
import 'package:psp_developer/src/blocs/login_bloc.dart';
import 'package:psp_developer/src/blocs/modules_bloc.dart';
import 'package:psp_developer/src/blocs/new_parts_bloc.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/blocs/projects_bloc.dart';
import 'package:psp_developer/src/blocs/reusable_parts_bloc.dart';
import 'package:psp_developer/src/blocs/test_reports_bloc.dart';
import 'package:psp_developer/src/blocs/time_logs_bloc.dart';

class BlocProvider {
  final _loginBloc = LoginBloc();
  final _projectsBloc = ProjectsBloc();
  final _modulesBloc = ModulesBloc();

  final _programsBloc = ProgramsBloc();
  final _basePartsBloc = BasePartsBloc();
  final _reusablePartsBloc = ReusablePartsBloc();
  final _newPartsBloc = NewPartsBloc();

  final _defectLogsBloc = DefectLogsBloc();
  final _timeLogsBloc = TimeLogsBloc();

  final _testReportsBloc = TestReportsBloc();

  LoginBloc get loginBloc => _loginBloc;
  ProjectsBloc get projectsBloc => _projectsBloc;
  ModulesBloc get modulesBloc => _modulesBloc;

  ProgramsBloc get programsBloc => _programsBloc;
  BasePartsBloc get basePartsBloc => _basePartsBloc;
  ReusablePartsBloc get reusablePartsBloc => _reusablePartsBloc;
  NewPartsBloc get newPartsBloc => _newPartsBloc;

  DefectLogsBloc get defectLogsBloc => _defectLogsBloc;
  TimeLogsBloc get timeLogsBloc => _timeLogsBloc;

  TestReportsBloc get testReportsBloc => _testReportsBloc;
}
