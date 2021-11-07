import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/blocs/filtered_reads/filtered_reads.dart';
import 'package:sugar_balance/blocs/home_page_bloc.dart';
import 'package:sugar_balance/blocs/reads/reads.dart';
import 'package:sugar_balance/models/models.dart';
import 'package:sugar_balance/utils/date_utils.dart';

class FilteredReadsBloc
    extends Bloc<FilteredReadingEvent, FilteredReadingState> {
  final ReadsBloc readsBloc;
  final HomePageBloc homePageBloc;
  late StreamSubscription readsSubscription;
  late StreamSubscription homePageBlockSubscription;

  FilteredReadsBloc({required this.readsBloc, required this.homePageBloc})
      : super(FilteredReadLoading()) {
    readsSubscription = readsBloc.stream.listen((state) {
      if (state is ReadsLoaded) {
        add(UpdateReadings((readsBloc.state as ReadsLoaded).reads));
      }
    });
    homePageBlockSubscription = homePageBloc.dateStream
        .listen((date) => add(UpdateForDateFilter(homePageBloc.selectedDate)));
  }

  @override
  FilteredReadingState get initialState {
    return readsBloc.state is ReadsLoaded
        ? FilteredReadLoaded(
            (readsBloc.state as ReadsLoaded).reads,
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
    if (readsBloc.state is ReadsLoaded) {
      yield FilteredReadLoaded(
        _mapReadsToFilteredReads(
          (readsBloc.state as ReadsLoaded).reads,
          event.forDateFilter,
        ),
        event.forDateFilter,
      );
    }
  }

  Stream<FilteredReadingState> _mapReadsUpdatedToState(
    UpdateReadings event,
  ) async* {
    final forDateFilter = state is FilteredReadLoaded
        ? (state as FilteredReadLoaded).forDate
        : DateTime.now();
    yield FilteredReadLoaded(
      _mapReadsToFilteredReads(
        (readsBloc.state as ReadsLoaded).reads,
        forDateFilter,
      ),
      forDateFilter,
    );
  }

  List<Reading> _mapReadsToFilteredReads(List<Reading> reads, DateTime filter) {
    List<Reading> result =
        reads.where((read) => areDatesEqual(read.date, filter)).toList();
    result.sort((a, b) => dateTimeFromDateTimeAndTimeOfDay(a.date, a.time)
        .compareTo(dateTimeFromDateTimeAndTimeOfDay(b.date, b.time)));
    return result;
  }

  @override
  Future<void> close() async {
    readsSubscription.cancel();
    homePageBlockSubscription.cancel();
    super.close();
  }
}
