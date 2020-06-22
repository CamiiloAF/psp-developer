import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String _PREF_TOKEN = 'token';
  static const String _PREF_CURRENT_USER = 'currentUser';

  //For interruption
  static const String _PREF_TIME_LOG_ID_WHIT_PENDING_INTERRUPTION =
      'time_log_id_with_pending_interruption';
  static const String _PREF_PENDING_INTERRUPTION_START_AT =
      'pending_interruption_start_at';

  static final Preferences _instancia = Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET de token
  String get token {
    return _prefs.getString(_PREF_TOKEN) ?? '';
  }

  set token(String value) {
    _prefs.setString(_PREF_TOKEN, value);
  }

  void removeToken() {
    _prefs.remove(_PREF_TOKEN);
  }

  // GET y SET current user
  String get curentUser {
    return _prefs.getString(_PREF_CURRENT_USER) ?? '';
  }

  set curentUser(String value) {
    _prefs.setString(_PREF_CURRENT_USER, value);
  }

  // GET y SET interruption
  int get pendingInterruptionStartAt {
    return _prefs.getInt(_PREF_PENDING_INTERRUPTION_START_AT);
  }

  set pendingInterruptionStartAt(int value) {
    _prefs.setInt(_PREF_PENDING_INTERRUPTION_START_AT, value);
  }

  int get timeLogIdWithPendingInterruption {
    return _prefs.getInt(_PREF_TIME_LOG_ID_WHIT_PENDING_INTERRUPTION);
  }

  set timeLogIdWithPendingInterruption(int value) {
    _prefs.setInt(_PREF_TIME_LOG_ID_WHIT_PENDING_INTERRUPTION, value);
  }

  void removePendingInterruptionAndTimeLogId() {
    _prefs.remove(_PREF_PENDING_INTERRUPTION_START_AT);
    _prefs.remove(_PREF_TIME_LOG_ID_WHIT_PENDING_INTERRUPTION);
  }
}
