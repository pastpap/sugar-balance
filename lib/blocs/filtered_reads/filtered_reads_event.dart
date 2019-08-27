import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/models/models.dart';

@immutable
abstract class FilteredReadingEvent extends Equatable {
  FilteredReadingEvent([List props = const []]) : super(props);
}

class UpdateReadings extends FilteredReadingEvent {
  final List<Reading> readings;

  UpdateReadings(this.readings) : super([readings]);

  @override
  String toString() => 'UpdateReadings { readings: $readings }';
}

class UpdateForDateFilter extends FilteredReadingEvent {
  final DateTime forDateFilter;

  UpdateForDateFilter(this.forDateFilter) : super([forDateFilter]);

  @override
  String toString() => 'UpdateForDateFilter { forDateFilter: $forDateFilter }';
}
