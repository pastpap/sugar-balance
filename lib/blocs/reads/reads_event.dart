import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/models/models.dart';

@immutable
abstract class ReadsEvent extends Equatable {
  const ReadsEvent();

  @override
  List<Object> get props => [];
}

class LoadReads extends ReadsEvent {
  @override
  String toString() => 'LoadReads';
}

class AddRead extends ReadsEvent {
  final Reading read;

  const AddRead(this.read);

  @override
  String toString() => 'AddRead { read: $read }';

  @override
  List<Object> get props => [read];
}

class UpdateRead extends ReadsEvent {
  final Reading updatedRead;

  UpdateRead(this.updatedRead);

  @override
  String toString() => 'UpdateRead { updatedRead: $updatedRead }';

  @override
  List<Object> get props => [updatedRead];
}

class DeleteRead extends ReadsEvent {
  final Reading read;

  DeleteRead(this.read);

  @override
  String toString() => 'DeleteRead { read: $read }';

  @override
  List<Object> get props => [read];
}

class ClearCompleted extends ReadsEvent {
  @override
  String toString() => 'ClearCompleted';
}

class ToggleAll extends ReadsEvent {
  @override
  String toString() => 'ToggleAll';
}
