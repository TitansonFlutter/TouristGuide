part of 'admin_bloc_bloc.dart';

@immutable
abstract class AdminEvent extends Equatable {
  const AdminEvent();
}

class Agentsload extends AdminEvent {
  const Agentsload();

  @override
  List<Object> get props => [];
}

class CreateAgent extends AdminEvent {
  final User agent;

  const CreateAgent(this.agent);

  @override
  List<Object> get props => [agent];

  @override
  String toString() => "Agent Created {agent: $agent}";
}

class DeleteAgent extends AdminEvent {
  final int id;

  const DeleteAgent(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => "Agent Deleted {agent: $id}";
}
