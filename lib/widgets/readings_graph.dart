/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:sugarbalance/models/models.dart';

class ReadingsGraph extends StatelessWidget {
  final List<Reading>? reads;
  final bool? animate;

  ReadingsGraph({this.reads, this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      manageReadsData(),
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new charts.BarRendererConfig<DateTime>(maxBarWidthPx: 5),
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
    );
  }

  List<charts.Series<TimeSeriesRead, DateTime>> manageReadsData() {
    final data = <TimeSeriesRead>[];
    reads!.forEach((element) {
      final elementDate = new DateTime(element.date.year, element.date.month,
          element.date.day, element.time.hour, element.time.minute);
      data.add(new TimeSeriesRead(elementDate, element.value));
    });
    return [
      new charts.Series<TimeSeriesRead, DateTime>(
        id: 'ReadsChart',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesRead read, _) => read.time,
        measureFn: (TimeSeriesRead read, _) => read.readValue,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesRead {
  final DateTime time;
  final int? readValue;

  TimeSeriesRead(this.time, this.readValue);
}
