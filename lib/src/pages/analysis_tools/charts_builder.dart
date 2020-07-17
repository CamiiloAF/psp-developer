import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:psp_developer/src/models/graphics/i_graphics_model.dart';

class ChartsBuilder {
  final bool isDarkTheme;

  ChartsBuilder({@required this.isDarkTheme});

  Widget build(String title, List<IGraphicsModel> data) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            Center(
                child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            )),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: 200,
              child: charts.BarChart(
                _createSampleData(data),
                vertical: false,
                primaryMeasureAxis: _getPrimaryMeasureAxis(),
                domainAxis: _getDomainAxis(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<charts.Series<IGraphicsModel, String>> _createSampleData(
      List<IGraphicsModel> data) {
    return [
      charts.Series<IGraphicsModel, String>(
        id: 'Graphics',
        domainFn: (IGraphicsModel model, _) => model.domain,
        measureFn: (IGraphicsModel model, _) => model.measure,
        data: data,
        fillColorFn: (datum, index) => charts.Color.fromHex(code: '#607d8b'),
      )
    ];
  }

  charts.NumericAxisSpec _getPrimaryMeasureAxis() {
    return charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
                color: (isDarkTheme)
                    ? charts.MaterialPalette.white
                    : charts.MaterialPalette.black),
            lineStyle: charts.LineStyleSpec(
                color: charts.MaterialPalette.gray.shade400)));
  }

  charts.OrdinalAxisSpec _getDomainAxis() {
    return charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
      labelStyle: charts.TextStyleSpec(
          color: (!isDarkTheme)
              ? charts.MaterialPalette.gray.shade800
              : charts.MaterialPalette.white),
    ));
  }
}
