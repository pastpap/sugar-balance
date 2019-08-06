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
  final List<Reading> filteredTodos;
  final VisibilityFilter activeFilter;

  FilteredReadLoaded(this.filteredTodos, this.activeFilter)
      : super([filteredTodos, activeFilter]);

  @override
  String toString() {
    return 'FilteredReadLoaded { filteredTodos: $filteredTodos, activeFilter: $activeFilter }';
  }
}
