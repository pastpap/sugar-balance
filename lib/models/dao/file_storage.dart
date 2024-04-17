import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:sugarbalance/models/dao/core/reads_repository_core.dart';

/// Loads and saves a List of Reads using a text file stored on the device.
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
    final Map<String, dynamic> json = jsonDecode(string);
    final List<dynamic> listOfReads = json['reads'];
    final List<ReadEntity> entities = [];
    listOfReads.forEach((read) {
      entities.add(ReadEntity.fromJson(read));
    });

    return entities;
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
