import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/models/models.dart';

@immutable
abstract class FilteredReadingEvent extends Equatable {
  FilteredReadingEvent([List props = const []]) : super(props);
}

class UpdateFilter extends FilteredReadingEvent {
  final VisibilityFilter filter;

  UpdateFilter(this.filter) : super([filter]);

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateReadings extends FilteredReadingEvent {
  final List<Reading> readings;

  UpdateReadings(this.readings) : super([readings]);

  @override
  String toString() => 'UpdateReadings { readings: $readings }';
}
