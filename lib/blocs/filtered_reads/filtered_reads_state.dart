import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/models/models.dart';

@immutable
abstract class FilteredReadingState extends Equatable {
  FilteredReadingState([List props = const []]) : super(props);
}

class FilteredReadLoading extends FilteredReadingState {
  @override
  String toString() => 'FilteredReadLoading';
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
}
