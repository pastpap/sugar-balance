import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const <dynamic>[]]) : super();
}

class IncrementDate extends HomeEvent {
  final DateTime dateToIncrement;

  IncrementDate(this.dateToIncrement) : super([dateToIncrement]);

  @override
  String toString() =>
      'IncrementDate { dateToIncrement: $dateToIncrement.toIso8601String() }';

  @override
  List<Object> get props => [dateToIncrement];
}

class DecrementDate extends HomeEvent {
  final DateTime dateToDecrement;

  DecrementDate(this.dateToDecrement) : super([dateToDecrement]);

  @override
  String toString() =>
      'DecrementDate { dateToDecrement: $dateToDecrement.toIso8601String() }';

  @override
  List<Object> get props => [dateToDecrement];
}
