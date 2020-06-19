import 'package:psp_developer/src/blocs/login_bloc.dart';
import 'package:psp_developer/src/blocs/modules_bloc.dart';
import 'package:psp_developer/src/blocs/programs_bloc.dart';
import 'package:psp_developer/src/blocs/projects_bloc.dart';

class BlocProvider {
  final _loginBloc = LoginBloc();
  final _projectsBloc = ProjectsBloc();
  final _modulesBloc = ModulesBloc();
  final _programsBloc = ProgramsBloc();

  LoginBloc get loginBloc => _loginBloc;
  ProjectsBloc get projectsBloc => _projectsBloc;
  ModulesBloc get modulesBloc => _modulesBloc;
  ProgramsBloc get programsBloc => _programsBloc;
}
