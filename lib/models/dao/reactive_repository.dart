// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:sugar_balance/models/dao/core/reads_repository_core.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Reads and Persist reads.
class ReactiveReadsRepositoryFlutter implements ReactiveReadsRepository {
  final ReadsRepository _repository;
  final BehaviorSubject<List<ReadEntity>?> _subject;
  bool _loaded = false;

  ReactiveReadsRepositoryFlutter({
    required ReadsRepository repository,
    List<ReadEntity>? seedValue,
  })  : this._repository = repository,
        this._subject = BehaviorSubject<List<ReadEntity>?>.seeded(seedValue);

  @override
  Future<void> addNewRead(ReadEntity read) async {
    _subject.add(List.unmodifiable([]
      ..addAll(_subject.value ?? [])
      ..add(read)));

    await _repository.saveReads(_subject.value);
  }

  @override
  Future<void> deleteRead(List<String> idList) async {
    _subject.add(
      List<ReadEntity>.unmodifiable(_subject.value!.fold<List<ReadEntity>>(
        <ReadEntity>[],
        (prev, entity) {
          return idList.contains(entity.id) ? prev : (prev..add(entity));
        },
      )),
    );

    await _repository.saveReads(_subject.value);
  }

  @override
  Stream<List<ReadEntity>?> reads() {
    if (!_loaded) _loadReads();

    return _subject.stream;
  }

  void _loadReads() {
    _loaded = true;

    _repository.loadReads().then((entities) {
      _subject.add(List<ReadEntity>.unmodifiable(
        []..addAll(_subject.value ?? [])..addAll(entities!),
      ));
    });
  }

  @override
  Future<void> updateRead(ReadEntity update) async {
    _subject.add(
      List<ReadEntity>.unmodifiable(_subject.value!.fold<List<ReadEntity>>(
        <ReadEntity>[],
        (prev, entity) => prev..add(entity.id == update.id ? update : entity),
      )),
    );

    await _repository.saveReads(_subject.value);
  }
}
