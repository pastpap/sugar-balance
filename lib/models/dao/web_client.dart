// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sugar_balance/models/dao/core/reads_repository_core.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  Future<List<ReadEntity>> fetchReads() async {
    return Future.delayed(
        delay,
        () => [
              // ReadEntity(
              //   94,
              //   '1',
              //   'chickeny bits',
              //   new DateTime.now(),
              //   TimeOfDay(hour: 3, minute: 28),
              // ),
              // ReadEntity(
              //   105,
              //   '2',
              //   'chocolate bits',
              //   new DateTime.now(),
              //   TimeOfDay(hour: 7, minute: 55),
              // ),
              // ReadEntity(
              //   88,
              //   '3',
              //   'apple bits',
              //   new DateTime.now(),
              //   TimeOfDay(hour: 18, minute: 33),
              // ),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postReads(List<ReadEntity> reads) async {
    return Future.value(true);
  }
}
