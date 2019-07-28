// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';

class ReadEntity {
  final String id;
  final String note;
  final int value;
  final DateTime date;
  final TimeOfDay time;

  ReadEntity(this.value, this.id, this.note, this.date, this.time);

  @override
  int get hashCode =>
      value.hashCode ^
      note.hashCode ^
      date.hashCode ^
      time.hashCode ^
      id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadEntity &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          time == other.time &&
          value == other.value &&
          note == other.note &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      "value": value,
      "date": date,
      "time": time,
      "note": note,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'TodoEntity{date: $date, time: $time, value: $value, note: $note, id: $id}';
  }

  static ReadEntity fromJson(Map<String, Object> json) {
    return ReadEntity(
        json["value"] as int,
        json["id"] as String,
        json["note"] as String,
        json["date"] as DateTime,
        json["time"] as TimeOfDay);
  }
}
