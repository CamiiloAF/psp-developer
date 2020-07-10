import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/src/pages/login/login_page.dart';
import 'package:psp_developer/src/pages/projects/projects_page.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/fab_model.dart';
import 'package:psp_developer/src/providers/models/system_language_model.dart';
import 'package:psp_developer/src/providers/models/time_log_pending_interruption.dart';
import 'package:psp_developer/src/routes/routes.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/theme/theme_changer.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding();
  final prefs = Preferences();
  await prefs.initPrefs();

  runApp(MultiProvider(providers: [
    Provider<BlocProvider>(
      create: (_) => BlocProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => FabModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => ThemeChanger(Preferences().theme),
    ),
    ChangeNotifierProvider(
      create: (_) => TimelogPendingInterruptionModel(),
    ),
    ChangeNotifierProvider(
        create: (_) => SystemLanguageModel(prefs.languageCode)),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferences = Preferences();
    return MaterialApp(
        title: 'PSP - DEVELOPER',
        debugShowCheckedModeBanner: false,
        initialRoute: (preferences.token != '')
            ? ProjectsPage.ROUTE_NAME
            : LoginPage.ROUTE_NAME,
        routes: getApplicationRoutes(),
        theme: Provider.of<ThemeChanger>(context).currentTheme,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
          LocaleNamesLocalizationsDelegate(),
        ],
        locale: Provider.of<SystemLanguageModel>(context).locale,
        supportedLocales: S.delegate.supportedLocales);
  }
}
