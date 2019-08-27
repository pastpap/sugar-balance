import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const <dynamic>[]]) : super(props);
}

class InitialHomeState extends HomeState {
  final DateTime initialDate = new DateTime.now();

  @override
  String toString() {
    return 'InitialHomeState: {initialDate: $initialDate.toIso8601String() }';
  }
}

class IcrementDateHomeState extends HomeState {
  final DateTime incrementDate;

  IcrementDateHomeState(this.incrementDate) : super([incrementDate]);

  @override
  String toString() {
    return 'IcrementDateHomeState: {incrementDate: $incrementDate.toIso8601String() }';
  }
}

class DecrementDateHomeState extends HomeState {
  final DateTime decrementDate;

  DecrementDateHomeState(this.decrementDate) : super([decrementDate]);

  @override
  String toString() {
    return 'IcrementDateHomeState: {decrementDate: $decrementDate.toIso8601String()}';
  }
}
