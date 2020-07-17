import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psp_developer/generated/l10n.dart';
import 'package:psp_developer/src/models/graphics/graphics_model.dart';
import 'package:psp_developer/src/pages/analysis_tools/charts_builder.dart';
import 'package:psp_developer/src/utils/theme/theme_changer.dart';
import 'package:psp_developer/src/widgets/custom_app_bar.dart';

class AnalysisToolsPage extends StatelessWidget {
  static const ROUTE_NAME = 'analysis-tools';

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<ThemeChanger>(context).isDarkTheme;
    final chartsBuilder = ChartsBuilder(isDarkTheme: isDarkTheme);

    final s = S.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).appBarTitleAnalysisTools),
      body: ListView(
        children: [
          chartsBuilder.build(s.titleSizeOfPrograms, [
            SizeModel(
              programName: 'Name ipsum',
              totalLines: 90,
            ),
            SizeModel(
              programName: 'Programa 2',
              totalLines: 81,
            ),
            SizeModel(
              programName: 'Programa 24',
              totalLines: 2,
            ),
            SizeModel(
              programName: 'Programa 32',
              totalLines: 3,
            ),
            SizeModel(
              programName: 'Programa 11',
              totalLines: 841,
            ),
          ]),
          chartsBuilder.build(s.titleTotalDefects, [
            TotalDefectsByProgramModel(
                programName: 'Programa 3', totalDefects: 12),
            TotalDefectsByProgramModel(
                programName: 'Programa 4', totalDefects: 34),
          ])
        ],
      ),
    );
  }
}
