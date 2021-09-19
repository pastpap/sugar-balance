// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:sugar_balance/models/dao/core/reads_repository_core.dart';

/// Loads and saves a List of Todos using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  Future<List<ReadEntity>?> loadReads() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final reads = (json['reads'])
        .map<ReadEntity>((read) => ReadEntity.fromJson(read))
        .toList();

    return reads;
  }

  Future<File> saveReads(List<ReadEntity> reads) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'reads': reads.map((read) => read.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/ReadsStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}
