import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const <dynamic>[]]) : super();
}

class InitialHomeState extends HomeState {
  final DateTime initialDate = new DateTime.now();

  @override
  String toString() {
    return 'InitialHomeState: {initialDate: $initialDate.toIso8601String() }';
  }

  @override
  List<Object> get props => [initialDate];
}

class ChangedHomeState extends HomeState {
  final DateTime newModifiedDate;

  ChangedHomeState(this.newModifiedDate) : super([newModifiedDate]);

  @override
  String toString() {
    return 'ChangedHomeState: {newModifiedDate: $newModifiedDate.toIso8601String() }';
  }

  @override
  List<Object> get props => [newModifiedDate];
}
