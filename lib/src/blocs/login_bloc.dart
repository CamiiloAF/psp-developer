import 'package:psp_developer/src/blocs/experiences_bloc.dart';
import 'package:psp_developer/src/pages/experiences/experiences_page.dart';
import 'package:psp_developer/src/pages/projects/projects_page.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/utils.dart' as utils;
import 'package:rxdart/rxdart.dart';

import 'validators/validators.dart';

class LoginBloc with Validators {
  final preferences = Preferences();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  ExperiencesBloc _experiencesBloc;

  set experiencesBloc(ExperiencesBloc value) => _experiencesBloc = value;

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get formValidateStream =>
      Observable.combineLatest2(emailStream, passwordStream, (es, ps) => true);

  Function(String) get onEmailChange => _emailController.sink.add;
  Function(String) get onPasswordChange => _passwordController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;

  void addLoginAttemp() {
    final loginTries = preferences.loginAttemps;
    preferences.loginAttemps = loginTries + 1;

    _verifyLoginAttemps();
  }

  void _verifyLoginAttemps() {
    if (preferences.loginAttemps == 5) {
      preferences.loginLastAttempAt = DateTime.now().millisecondsSinceEpoch;
    }
  }

  void tryRestoreLoginAttemps() {
    final minutesBeetwenLoginLastAttempAndNow =
        getMinutesBeetwenLoginLastAttempAndNow();

    if (minutesBeetwenLoginLastAttempAndNow > 60) {
      preferences.restoreLoginAttemps();
    }
  }

  int getMinutesBeetwenLoginLastAttempAndNow() {
    final startDate =
        DateTime.fromMillisecondsSinceEpoch(preferences.loginLastAttempAt);

    return utils.getMinutesBetweenTwoDates(startDate, DateTime.now());
  }

  Future<String> getNextRoteName() async {
    final haveExperiences = await _experiencesBloc.haveExperiences();

    if (haveExperiences == null) return null;

    return (haveExperiences)
        ? ProjectsPage.ROUTE_NAME
        : ExperiencesPage.ROUTE_NAME;
  }

  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
