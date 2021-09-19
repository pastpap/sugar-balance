import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sugar_balance/models/models.dart';

@immutable
abstract class ReadsEvent extends Equatable {
  ReadsEvent([List props = const []]) : super();
}

class LoadReads extends ReadsEvent {
  @override
  String toString() => 'LoadReads';

  @override
  // TODO: implement props
  List<Object> get props => this.props;
}

class AddRead extends ReadsEvent {
  final Reading read;

  AddRead(this.read) : super([read]);

  @override
  String toString() => 'AddRead { read: $read }';

  @override
  List<Object> get props => [read];
}

class UpdateRead extends ReadsEvent {
  final Reading updatedRead;

  UpdateRead(this.updatedRead) : super([updatedRead]);

  @override
  String toString() => 'UpdateRead { updatedRead: $updatedRead }';

  @override
  List<Object> get props => [updatedRead];
}

class DeleteRead extends ReadsEvent {
  final Reading? read;

  DeleteRead(this.read) : super([read]);

  @override
  String toString() => 'DeleteRead { read: $read }';

  @override
  List<Object?> get props => [read];
}

class ClearCompleted extends ReadsEvent {
  @override
  String toString() => 'ClearCompleted';

  @override
  List<Object> get props => [];
}

class ToggleAll extends ReadsEvent {
  @override
  String toString() => 'ToggleAll';

  @override
  List<Object> get props => [];
}
