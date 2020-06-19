/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:sugar_balance/models/models.dart';

class ReadingsGraph extends StatelessWidget {
  final List<Reading> reads;
  final bool animate;

  ReadingsGraph({this.reads, this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      manageReadsData(),
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
    );
  }

  List<charts.Series<TimeSeriesReads, DateTime>> manageReadsData() {
    final data = new List<TimeSeriesReads>();
    reads.forEach((element) {
      data.add(new TimeSeriesReads(element.date, element.value));
    });
    return [
      new charts.Series<TimeSeriesReads, DateTime>(
        id: 'ReadsChart',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesReads sales, _) => sales.time,
        measureFn: (TimeSeriesReads sales, _) => sales.readValue,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesReads {
  final DateTime time;
  final int readValue;

  TimeSeriesReads(this.time, this.readValue);
}
