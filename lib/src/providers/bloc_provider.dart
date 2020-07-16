import 'package:psp_developer/src/blocs/base_parts_bloc.dart';
import 'package:psp_developer/src/blocs/defect_logs_bloc.dart';
import 'package:psp_developer/src/blocs/experiences_bloc.dart';
import 'package:psp_developer/src/blocs/languages_bloc.dart';
import 'package:psp_developer/src/blocs/login_bloc.dart';
import 'package:psp_developer/src/blocs/modules_bloc.dart';
import 'package:psp_developer/src/blocs/new_parts_bloc.dart';
import 'package:psp_developer/src/blocs/pip_bloc.dart';
import 'package:psp_developer/src/blocs/program_plan_summary_bloc.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/blocs/projects_bloc.dart';
import 'package:psp_developer/src/blocs/reusable_parts_bloc.dart';
import 'package:psp_developer/src/blocs/test_reports_bloc.dart';
import 'package:psp_developer/src/blocs/time_logs_bloc.dart';
import 'package:psp_developer/src/blocs/users_bloc.dart';

class BlocProvider {
  final _experiencesBloc = ExperiencesBloc();
  final _loginBloc = LoginBloc();

  final _projectsBloc = ProjectsBloc();
  final _modulesBloc = ModulesBloc();

  final _programsBloc = ProgramsBloc();
  final _languagesBloc = LanguagesBloc();

  final _basePartsBloc = BasePartsBloc();
  final _reusablePartsBloc = ReusablePartsBloc();
  final _newPartsBloc = NewPartsBloc();

  final _defectLogsBloc = DefectLogsBloc();
  final _timeLogsBloc = TimeLogsBloc();

  final _testReportsBloc = TestReportsBloc();
  final _pipBloc = PIPBloc();

  final _userBloc = UsersBloc();

  final _programPlanSummaryBloc = ProgramPlanSummaryBloc();

  LoginBloc get loginBloc {
    _loginBloc.experiencesBloc = _experiencesBloc;
    return _loginBloc;
  }

  ExperiencesBloc get experiencesBloc => _experiencesBloc;

  ProjectsBloc get projectsBloc => _projectsBloc;

  ModulesBloc get modulesBloc => _modulesBloc;

  ProgramsBloc get programsBloc => _programsBloc;

  LanguagesBloc get languagesBloc => _languagesBloc;

  BasePartsBloc get basePartsBloc => _basePartsBloc;

  ReusablePartsBloc get reusablePartsBloc => _reusablePartsBloc;

  NewPartsBloc get newPartsBloc => _newPartsBloc;

  DefectLogsBloc get defectLogsBloc => _defectLogsBloc;

  TimeLogsBloc get timeLogsBloc => _timeLogsBloc;

  TestReportsBloc get testReportsBloc => _testReportsBloc;

  PIPBloc get pipBloc => _pipBloc;

  UsersBloc get userBloc => _userBloc;

  ProgramPlanSummaryBloc get programPlanSummaryBloc => _programPlanSummaryBloc;
}
