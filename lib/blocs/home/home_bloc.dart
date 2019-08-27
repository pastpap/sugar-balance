import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is IncrementDate) {
      yield* _mapIncrementDateToState(event);
    } else if (event is DecrementDate) {
      yield* _mapDecrementDateToState(event);
    }
  }
}

Stream<HomeState> _mapIncrementDateToState(IncrementDate event) async* {
  if (currentState is InitialHomeState) {}
}

Stream<HomeState> _mapDecrementDateToState(DecrementDate event) async* {}
