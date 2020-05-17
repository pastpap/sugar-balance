import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/models/models.dart';

@immutable
abstract class ReadsState extends Equatable {
  ReadsState([List props = const []]) : super();
}

class ReadsLoading extends ReadsState {
  @override
  String toString() => 'ReadsLoading';

  @override
  List<Object> get props => [];
}

class ReadsLoaded extends ReadsState {
  final List<Reading> reads;

  ReadsLoaded([this.reads = const []]) : super([reads]);

  @override
  String toString() => 'ReadsLoaded { reads: $reads }';

  @override
  List<Object> get props => [reads];
}

class ReadsNotLoaded extends ReadsState {
  @override
  String toString() => 'ReadsNotLoaded';

  @override
  List<Object> get props => [];
}
