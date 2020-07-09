import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String _PREF_TOKEN = 'token';
  static const String _PREF_TOKEN_SAVED_AT = 'tokenSavedAt';

  static const String _PREF_CURRENT_USER = 'currentUser';

  static const String _PREF_lOGIN_ATTEMPS = 'loginTries';
  static const String _PREF_lOGIN_LAST_ATTEMP_AT = 'loginlastTryAt';

  //For interruption
  static const String _PREF_TIME_LOG_ID_WHIT_PENDING_INTERRUPTION =
      'time_log_id_with_pending_interruption';
  static const String _PREF_PENDING_INTERRUPTION_START_AT =
      'pending_interruption_start_at';

  static const String _PREF_THEME = 'theme';

  static final Preferences _instancia = Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  void initPrefs() async => _prefs = await SharedPreferences.getInstance();

  // * Token
  String get token => _prefs.getString(_PREF_TOKEN) ?? '';
  set token(String value) => _prefs.setString(_PREF_TOKEN, value);

  int get tokenSavedAt => _prefs.getInt(_PREF_TOKEN_SAVED_AT);
  set tokenSavedAt(int value) => _prefs.setInt(_PREF_TOKEN_SAVED_AT, value);

  // GET y SET current user
  String get curentUser => _prefs.getString(_PREF_CURRENT_USER) ?? '';

  set curentUser(String value) => _prefs.setString(_PREF_CURRENT_USER, value);

  // * TimeLog Interruption
  int get pendingInterruptionStartAt =>
      _prefs.getInt(_PREF_PENDING_INTERRUPTION_START_AT);

  set pendingInterruptionStartAt(int value) =>
      _prefs.setInt(_PREF_PENDING_INTERRUPTION_START_AT, value);

  int get timeLogIdWithPendingInterruption =>
      _prefs.getInt(_PREF_TIME_LOG_ID_WHIT_PENDING_INTERRUPTION);

  set timeLogIdWithPendingInterruption(int value) =>
      _prefs.setInt(_PREF_TIME_LOG_ID_WHIT_PENDING_INTERRUPTION, value);

  void removePendingInterruptionAndTimeLogId() {
    _prefs.remove(_PREF_PENDING_INTERRUPTION_START_AT);
    _prefs.remove(_PREF_TIME_LOG_ID_WHIT_PENDING_INTERRUPTION);
  }

  // * Theme
  // 1 is light - 2 is dark
  int get theme => _prefs.getInt(_PREF_THEME) ?? 1;

  set theme(int value) => _prefs.setInt(_PREF_THEME, value);

 // * Login tries
  int get loginAttemps => _prefs.getInt(_PREF_lOGIN_ATTEMPS) ?? 0;
  set loginAttemps(int value) => _prefs.setInt(_PREF_lOGIN_ATTEMPS, value);

  int get loginLastAttempAt => _prefs.getInt(_PREF_lOGIN_LAST_ATTEMP_AT);
  set loginLastAttempAt(int value) =>
      _prefs.setInt(_PREF_lOGIN_LAST_ATTEMP_AT, value);

  void restoreLoginAttemps() {
    _prefs.remove(_PREF_lOGIN_ATTEMPS);
    _prefs.remove(_PREF_lOGIN_LAST_ATTEMP_AT);
  }

  void clearPreferences() async => await _prefs.clear();
}
