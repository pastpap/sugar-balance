import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/models/uuid.dart';

@immutable
class Reading extends Equatable {
  final String id;
  final int value;
  final DateTime date;
  final String note;

  Reading(this.value, this.date, {String note = '', String id})
      : this.note = note ?? '',
        this.id = id ?? Uuid().generateV4(),
        super([id, value, date, note]);
}
