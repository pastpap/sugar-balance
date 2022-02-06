import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugarbalance/models/models.dart';

@immutable
abstract class FilteredReadingState extends Equatable {
  FilteredReadingState([List props = const []]) : super();
}

class FilteredReadLoading extends FilteredReadingState {
  @override
  String toString() => 'FilteredReadLoading';

  @override
  List<Object> get props => [];
}

class FilteredReadLoaded extends FilteredReadingState {
  final List<Reading> filteredReads;
  final DateTime forDate;

  FilteredReadLoaded(this.filteredReads, this.forDate)
      : super([filteredReads, forDate]);

  @override
  String toString() {
    return 'FilteredReadLoaded { filteredReads: $filteredReads, forDate: $forDate}';
  }

  @override
  List<Object> get props => [filteredReads, forDate];
}
