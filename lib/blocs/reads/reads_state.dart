import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/models/models.dart';

@immutable
abstract class ReadsState extends Equatable {
  ReadsState([List props = const []]) : super(props);
}

class ReadsLoading extends ReadsState {
  @override
  String toString() => 'ReadsLoading';
}

class ReadsLoaded extends ReadsState {
  final List<Reading> reads;

  ReadsLoaded([this.reads = const []]) : super([reads]);

  @override
  String toString() => 'ReadsLoaded { reads: $reads }';
}

class ReadsNotLoaded extends ReadsState {
  @override
  String toString() => 'ReadsNotLoaded';
}
