import 'dart:async';
import 'dart:core';

import 'package:sugarbalance/models/dao/core/reads_repository_core.dart';

import 'file_storage.dart';

class ReadsRepositoryFlutter implements ReadsRepository {
  final FileStorage fileStorage;

  const ReadsRepositoryFlutter({
    required this.fileStorage,
  });

  @override
  Future<List<ReadEntity>?> loadReads() async {
    try {
      return await fileStorage.loadReads();
    } catch (e) {
      return <ReadEntity>[];
    }
  }

  @override
  Future saveReads(List<ReadEntity>? reads) {
    return Future.wait<dynamic>([
      fileStorage.saveReads(reads!),
    ]);
  }
}
