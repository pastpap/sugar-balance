import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugarbalance/models/models.dart';

@immutable
abstract class ReadsState extends Equatable {
  const ReadsState();

  @override
  List<Object> get props => [];
}

class ReadsLoading extends ReadsState {
  @override
  String toString() => 'ReadsLoading';
}

class ReadsLoaded extends ReadsState {
  final List<Reading> reads;

  ReadsLoaded([this.reads = const []]);

  @override
  String toString() => 'ReadsLoaded { reads: $reads }';

  @override
  List<Object> get props => [reads];
}

class ReadsNotLoaded extends ReadsState {
  @override
  String toString() => 'ReadsNotLoaded';
}
