// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:sugar_balance/models/dao/core/reads_repository_core.dart';

import 'file_storage.dart';
import 'web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class ReadsRepositoryFlutter implements ReadsRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const ReadsRepositoryFlutter({
    @required this.fileStorage,
    this.webClient = const WebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<ReadEntity>> loadReads() async {
    try {
      return await fileStorage.loadReads();
    } catch (e) {
      return new List<ReadEntity>();
    }
  }

  // Persists todos to local disk and the web
  @override
  Future saveReads(List<ReadEntity> reads) {
    return Future.wait<dynamic>([
      fileStorage.saveReads(reads),
    ]);
  }
}
