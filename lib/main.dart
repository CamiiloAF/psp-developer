import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
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
      create: (_) => ThemeChanger(1),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferences = Preferences();
    return MaterialApp(
        title: 'PSP - DEVELOPER',
        debugShowCheckedModeBanner: false,
        initialRoute: (preferences.token != '') ? 'projects' : 'login',
        routes: getApplicationRoutes(),
        // home: ProgramItemsPage(),
        theme: Provider.of<ThemeChanger>(context).currentTheme,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate
        ],
        supportedLocales: S.delegate.supportedLocales);
  }
}
