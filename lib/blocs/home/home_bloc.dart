import 'dart:async';

import 'package:bloc/bloc.dart';

import './home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(initialState);

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is IncrementDate) {
      yield* _mapIncrementDateToState(event);
    } else if (event is DecrementDate) {
      yield* _mapDecrementDateToState(event);
    }
  }

  Stream<HomeState> _mapIncrementDateToState(IncrementDate event) async* {
    DateTime incrementedDate = (state as ChangedHomeState).newModifiedDate;
    yield ChangedHomeState(incrementedDate.add(Duration(days: 1)));
  }

  Stream<HomeState> _mapDecrementDateToState(DecrementDate event) async* {
    if (state is InitialHomeState) {
      DateTime incrementedDate = (state as InitialHomeState).initialDate;
      yield ChangedHomeState(incrementedDate.add(Duration(days: 1)));
    }
  }
}
