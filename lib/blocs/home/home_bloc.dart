import 'dart:async';
import 'package:bloc/bloc.dart';
import './home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
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
    DateTime incrementedDate =
        (currentState as ChangedHomeState).newModifiedDate;
    yield ChangedHomeState(incrementedDate.add(Duration(days: 1)));
  }

  Stream<HomeState> _mapDecrementDateToState(DecrementDate event) async* {
    if (currentState is InitialHomeState) {
      DateTime incrementedDate = (currentState as InitialHomeState).initialDate;
      yield ChangedHomeState(incrementedDate.add(Duration(days: 1)));
    }
  }
}
