import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:psp_developer/src/pages/programs/program_parts/program_parts_page.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/providers/models/fab_model.dart';
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
      create: (_) => ThemeChanger(1),
    ),
    ChangeNotifierProvider(
      create: (_) => TimelogPendingInterruptionModel(),
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
        // initialRoute: (preferences.token != '') ? 'p' : 'login',
        routes: getApplicationRoutes(),
        home: ProgramPartsPage(),
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
