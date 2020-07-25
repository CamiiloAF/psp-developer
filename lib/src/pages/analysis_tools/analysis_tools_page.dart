import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/blocs/analysis_tools_bloc.dart';
import 'package:psp_developer/src/pages/analysis_tools/charts_builder.dart';
import 'package:psp_developer/src/providers/bloc_provider.dart';
import 'package:psp_developer/src/shared_preferences/shared_preferences.dart';
import 'package:psp_developer/src/utils/theme/theme_changer.dart';
import 'package:psp_developer/src/utils/token_handler.dart';
import 'package:psp_developer/src/widgets/common_list_of_models.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';
import 'package:psp_developer/src/widgets/not_authorized_screen.dart';

class AnalysisToolsPage extends StatefulWidget {
  static const ROUTE_NAME = 'analysis-tools';

  @override
  _AnalysisToolsPageState createState() => _AnalysisToolsPageState();
}

class _AnalysisToolsPageState extends State<AnalysisToolsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AnalysisToolsBloc _analysisToolsBloc;

  int _currentUserId;

  @override
  void initState() {
    _currentUserId = json.decode(Preferences().currentUser)['id'];

    _analysisToolsBloc = context.read<BlocProvider>().analysisToolsBloc;
    _analysisToolsBloc.getAnalysisTools(_currentUserId);
    super.initState();
  }

  @override
  void dispose() {
    _analysisToolsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!TokenHandler.existToken()) return NotAuthorizedScreen();

    return Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(title: S.of(context).appBarTitleAnalysisTools),
        body: _buildBody());
  }

  Widget _buildBody() => CommonListOfModels(
        stream: _analysisToolsBloc.analysisToolsStream,
        onRefresh: _onRefreshAnalysisTools,
        scaffoldKey: _scaffoldKey,
        buildListView: (items) => buildListView(),
      );

  Widget buildListView() {
    final isDarkTheme = Provider.of<ThemeChanger>(context).isDarkTheme;
    final chartsBuilder = ChartsBuilder(isDarkTheme: isDarkTheme);

    final s = S.of(context);

    return ListView(
      children: [
        chartsBuilder.build(s.titleSizeOfPrograms,
            [..._analysisToolsBloc.getTotalSizesPerProgram()]),
        chartsBuilder.build(s.titleTotalTimes,
            [..._analysisToolsBloc.getTotalTimesPerProgram()]),
        chartsBuilder.build(s.titleTotalDefects,
            [..._analysisToolsBloc.getTotalDefectsPerProgram()]),
        chartsBuilder.build(s.titleDefectsInjectedPerPhase,
            [..._analysisToolsBloc.getDefectsInjectedPerPhase()]),
        chartsBuilder.build(s.titleDefectsRemovedPerPhase,
            [..._analysisToolsBloc.getDefectsRemovedPerPhase()]),
      ],
    );
  }

  Future<void> _onRefreshAnalysisTools() async =>
      await _analysisToolsBloc.getAnalysisTools(_currentUserId);
}
