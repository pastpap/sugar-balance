import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/models/dao/core/reads_repository_core.dart';
import 'package:sugar_balance/models/uuid.dart';

@immutable
class Reading extends Equatable {
  final String id;
  final int value;
  final String meal;
  final String periodOfMeal;
  final DateTime date;
  final TimeOfDay time;
  final String note;

  Reading(this.value, this.date, this.time, this.meal, this.periodOfMeal,
      {String note = '', String id})
      : this.note = note ?? '',
        this.id = id ?? Uuid().generateV4(),
        super([id, value, date, time, note, meal, periodOfMeal]);

  Reading copyWith(
      {String id,
      String note,
      String meal,
      String periodOfMeal,
      int value,
      DateTime date,
      TimeOfDay time}) {
    return Reading(value ?? this.value, date ?? this.date, time ?? this.time,
        meal ?? this.meal, periodOfMeal ?? this.periodOfMeal,
        id: id ?? this.id, note: note ?? this.note);
  }

  @override
  String toString() {
    return 'Read { value: $value, note: $note, meal: $meal, periodOfMeal: $periodOfMeal id: $id, date: $date, time: $time }';
  }

  ReadEntity toEntity() {
    return ReadEntity(value, id, note, meal, periodOfMeal, date, time);
  }

  static Reading fromEntity(ReadEntity entity) {
    return Reading(
      entity.value,
      entity.date,
      entity.time,
      entity.meal,
      entity.periodOfMeal,
      note: entity.note,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}
