import 'dart:async';

class HomePageBloc {
  DateTime selectedDate = DateTime.now();
  //final FilteredReadsBloc filteredReadsBloc;

  final StreamController<DateTime> _dateStreamController =
      StreamController.broadcast();

  Stream<DateTime> get dateStream =>
      _dateStreamController.stream.asBroadcastStream();
  void addDate() {
    selectedDate = selectedDate.add(Duration(days: 1));
    _dateStreamController.sink.add(selectedDate);
  }

  void subtractDate() {
    selectedDate = selectedDate.subtract(Duration(days: 1));
    _dateStreamController.sink.add(selectedDate);
  }

  dispose() {
    _dateStreamController.close();
  }
}
