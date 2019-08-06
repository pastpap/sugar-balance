import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/blocs/filtered_reads/filtered_reads_event.dart';
import 'package:sugar_balance/blocs/filtered_reads/filtered_reads_state.dart';
import 'package:sugar_balance/models/models.dart';
import 'package:sugar_balance/blocs/reads/reads.dart';

class FilteredReadsBloc
    extends Bloc<FilteredReadingEvent, FilteredReadingState> {
  final ReadsBloc readsBloc;
  StreamSubscription readsSubscription;

  FilteredReadsBloc({@required this.readsBloc}) {
    readsSubscription = readsBloc.state.listen((state) {
      if (state is ReadsLoaded) {
        dispatch(UpdateReadings((readsBloc.currentState as ReadsLoaded).reads));
      }
    });
  }

  @override
  FilteredReadingState get initialState {
    return readsBloc.currentState is ReadsLoaded
        ? FilteredReadLoaded(
            (readsBloc.currentState as ReadsLoaded).reads,
            VisibilityFilter.all,
          )
        : FilteredReadLoading();
  }

  @override
  Stream<FilteredReadingState> mapEventToState(
      FilteredReadingEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateReadings) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<FilteredReadingState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    if (readsBloc.currentState is ReadsLoaded) {
      yield FilteredReadLoaded(
        _mapTodosToFilteredTodos(
          (readsBloc.currentState as ReadsLoaded).reads,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredReadingState> _mapTodosUpdatedToState(
    UpdateReadings event,
  ) async* {
    final visibilityFilter = currentState is FilteredReadLoaded
        ? (currentState as FilteredReadLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredReadLoaded(
      _mapTodosToFilteredTodos(
        (readsBloc.currentState as ReadsLoaded).reads,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Reading> _mapTodosToFilteredTodos(
      List<Reading> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      }
    }).toList();
  }

  @override
  void dispose() {
    readsSubscription.cancel();
    super.dispose();
  }
}
