import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sugarbalance/blocs/reads/reads.dart';
import 'package:sugarbalance/models/dao/reads_repository_simple.dart';
import 'package:sugarbalance/models/models.dart';

class ReadsBloc extends Bloc<ReadsEvent, ReadsState> {
  final ReadsRepositoryFlutter readsRepository;

  ReadsBloc({required this.readsRepository}) : super(ReadsLoading());

  @override
  Stream<ReadsState> mapEventToState(ReadsEvent event) async* {
    if (event is LoadReads) {
      yield* _mapLoadReadsToState();
    } else if (event is AddRead) {
      yield* _mapAddReadToState(event);
    } else if (event is UpdateRead) {
      yield* _mapUpdateReadToState(event);
    } else if (event is DeleteRead) {
      yield* _mapDeleteReadToState(event);
    }
  }

  Stream<ReadsState> _mapLoadReadsToState() async* {
    try {
      final reads = await this.readsRepository.loadReads();
      yield ReadsLoaded(
        reads!.map(Reading.fromEntity).toList(),
      );
    } catch (_) {
      yield ReadsNotLoaded();
    }
  }

  Stream<ReadsState> _mapAddReadToState(AddRead event) async* {
    if (state is ReadsLoaded) {
      final List<Reading> updatedReads = List.from((state as ReadsLoaded).reads)
        ..add(event.read);
      yield ReadsLoaded(updatedReads);
      _saveReads(updatedReads);
    }
  }

  Stream<ReadsState> _mapUpdateReadToState(UpdateRead event) async* {
    if (state is ReadsLoaded) {
      final List<Reading> updatedReads =
          (state as ReadsLoaded).reads.map((read) {
        return read.id == event.updatedRead.id ? event.updatedRead : read;
      }).toList();
      yield ReadsLoaded(updatedReads);
      _saveReads(updatedReads);
    }
  }

  Stream<ReadsState> _mapDeleteReadToState(DeleteRead event) async* {
    if (state is ReadsLoaded) {
      final updatedReads = (state as ReadsLoaded)
          .reads
          .where((read) => read.id != event.read.id)
          .toList();
      yield ReadsLoaded(updatedReads);
      _saveReads(updatedReads);
    }
  }

  Future _saveReads(List<Reading> reads) {
    return readsRepository.saveReads(
      reads.map((read) => read.toEntity()).toList(),
    );
  }
}
