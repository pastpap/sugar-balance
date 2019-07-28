import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/models/models.dart';

@immutable
abstract class ReadsEvent extends Equatable {
  ReadsEvent([List props = const []]) : super(props);
}

class LoadReads extends ReadsEvent {
  @override
  String toString() => 'LoadReads';
}

class AddRead extends ReadsEvent {
  final Reading read;

  AddRead(this.read) : super([read]);

  @override
  String toString() => 'AddRead { read: $read }';
}

class UpdateRead extends ReadsEvent {
  final Reading updatedRead;

  UpdateRead(this.updatedRead) : super([updatedRead]);

  @override
  String toString() => 'UpdateTodo { updatedRead: $updatedRead }';
}

class DeleteRead extends ReadsEvent {
  final Reading read;

  DeleteRead(this.read) : super([read]);

  @override
  String toString() => 'DeleteRead { read: $read }';
}

class ClearCompleted extends ReadsEvent {
  @override
  String toString() => 'ClearCompleted';
}

class ToggleAll extends ReadsEvent {
  @override
  String toString() => 'ToggleAll';
}
