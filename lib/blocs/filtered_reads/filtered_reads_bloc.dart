import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/blocs/filtered_reads/filtered_reads.dart';
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
      yield* _mapReadsUpdatedToState(event);
    }
  }

  Stream<FilteredReadingState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    if (readsBloc.currentState is ReadsLoaded) {
      yield FilteredReadLoaded(
        _mapReadsToFilteredReads(
          (readsBloc.currentState as ReadsLoaded).reads,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredReadingState> _mapReadsUpdatedToState(
    UpdateReadings event,
  ) async* {
    final visibilityFilter = currentState is FilteredReadLoaded
        ? (currentState as FilteredReadLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredReadLoaded(
      _mapReadsToFilteredReads(
        (readsBloc.currentState as ReadsLoaded).reads,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Reading> _mapReadsToFilteredReads(
      List<Reading> reads, VisibilityFilter filter) {
    return reads.where((read) {
      if (filter == VisibilityFilter.all) {
        return true;
      }
      return false;
    }).toList();
  }

  @override
  void dispose() {
    readsSubscription.cancel();
    super.dispose();
  }
}
