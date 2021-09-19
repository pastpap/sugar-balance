import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sugar_balance/blocs/reads/reads.dart';
import 'package:sugar_balance/models/dao/core/reads_repository_core.dart';
import 'package:sugar_balance/models/dao/reads_repository_simple.dart';
import 'package:sugar_balance/models/models.dart';

class ReadsBloc extends Bloc<ReadsEvent, ReadsState> {
  final ReadsRepositoryFlutter todosRepository;

  ReadsBloc({required this.todosRepository}) : super(ReadsLoading());

  ReadsState get initialState => ReadsLoading();

  @override
  Stream<ReadsState> mapEventToState(ReadsEvent event) async* {
    if (event is LoadReads) {
      yield* _mapLoadReadsToState();
    } else if (event is AddRead) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateRead) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteRead) {
      yield* _mapDeleteTodoToState(event);
    }
  }

  Stream<ReadsState> _mapLoadReadsToState() async* {
    try {
      final reads = await (this.todosRepository.loadReads()
          as FutureOr<List<ReadEntity>>);
      yield ReadsLoaded(
        reads.map(Reading.fromEntity).toList(),
      );
    } catch (_) {
      yield ReadsNotLoaded();
    }
  }

  Stream<ReadsState> _mapAddTodoToState(AddRead event) async* {
    if (state is ReadsLoaded) {
      final List<Reading> updatedReads = List.from((state as ReadsLoaded).reads)
        ..add(event.read);
      yield ReadsLoaded(updatedReads);
      _saveReads(updatedReads);
    }
  }

  Stream<ReadsState> _mapUpdateTodoToState(UpdateRead event) async* {
    if (state is ReadsLoaded) {
      final List<Reading> updatedReads =
          (state as ReadsLoaded).reads.map((read) {
        return read.id == event.updatedRead.id ? event.updatedRead : read;
      }).toList();
      yield ReadsLoaded(updatedReads);
      _saveReads(updatedReads);
    }
  }

  Stream<ReadsState> _mapDeleteTodoToState(DeleteRead event) async* {
    if (state is ReadsLoaded) {
      final updatedReads = (state as ReadsLoaded)
          .reads
          .where((read) => read.id != event.read!.id)
          .toList();
      yield ReadsLoaded(updatedReads);
      _saveReads(updatedReads);
    }
  }

  Future _saveReads(List<Reading> reads) {
    return todosRepository.saveReads(
      reads.map((read) => read.toEntity()).toList(),
    );
  }
}
