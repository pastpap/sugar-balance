// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'read_entity.dart';

/// A class that Loads and Persists reads. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as reads_repository_simple or reads_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class ReadsRepository {
  /// Loads reads first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Reads from a Web Client.
  Future<List<ReadEntity>> loadReads();

  // Persists reads to local disk and the web
  Future saveReads(List<ReadEntity> reads);
}
