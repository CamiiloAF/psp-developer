import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  bool _isDarkTheme = false;
  final preferences = Preferences();

  ThemeData _currentTheme;

  bool get isDarkTheme => _isDarkTheme;
  ThemeData get currentTheme => _currentTheme;

  ThemeChanger(int theme) {
    switch (theme) {
      case 1:
        _isDarkTheme = false;
        _currentTheme = _lightThemeData();
        break;
      case 2:
        _isDarkTheme = true;
        _currentTheme = _darkThemeData();
        break;
      default:
        _isDarkTheme = false;
        _currentTheme = ThemeData.light();
    }
  }

  set isDarkTheme(bool value) {
    _isDarkTheme = value;

    if (value) {
      _currentTheme = _darkThemeData();
    } else {
      _currentTheme = _lightThemeData();
    }

    preferences.theme = (value) ? 2 : 1;
    notifyListeners();
  }

  static const _ACCENT_COLOR = Color(0xFF607d8b);
  static const _PRIMARY_COLOR = Color(0xffff7043);

  ThemeData _darkThemeData() => ThemeData.dark().copyWith(
      accentColor: _ACCENT_COLOR,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: _ACCENT_COLOR),
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()));

  ThemeData _lightThemeData() => ThemeData.light().copyWith(
      accentColor: _ACCENT_COLOR,
      primaryColor: _PRIMARY_COLOR,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: _ACCENT_COLOR),
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()));
}
