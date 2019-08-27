import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/blocs/filtered_reads/filtered_reads.dart';
import 'package:sugar_balance/models/models.dart';
import 'package:sugar_balance/blocs/reads/reads.dart';
import 'package:sugar_balance/utils/date_utils.dart';

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
            DateTime.now(),
          )
        : FilteredReadLoading();
  }

  @override
  Stream<FilteredReadingState> mapEventToState(
      FilteredReadingEvent event) async* {
    if (event is UpdateForDateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateReadings) {
      yield* _mapReadsUpdatedToState(event);
    }
  }

  Stream<FilteredReadingState> _mapUpdateFilterToState(
    UpdateForDateFilter event,
  ) async* {
    if (readsBloc.currentState is ReadsLoaded) {
      yield FilteredReadLoaded(
        _mapReadsToFilteredReads(
          (readsBloc.currentState as ReadsLoaded).reads,
          event.forDateFilter,
        ),
        event.forDateFilter,
      );
    }
  }

  Stream<FilteredReadingState> _mapReadsUpdatedToState(
    UpdateReadings event,
  ) async* {
    final forDateFilter = currentState is FilteredReadLoaded
        ? (currentState as FilteredReadLoaded).forDate
        : DateTime.now();
    yield FilteredReadLoaded(
      _mapReadsToFilteredReads(
        (readsBloc.currentState as ReadsLoaded).reads,
        forDateFilter,
      ),
      forDateFilter,
    );
  }

  List<Reading> _mapReadsToFilteredReads(List<Reading> reads, DateTime filter) {
    return reads.where((read) => areDatesEqual(read.date, filter)).toList();
  }

  @override
  void dispose() {
    readsSubscription.cancel();
    super.dispose();
  }
}
