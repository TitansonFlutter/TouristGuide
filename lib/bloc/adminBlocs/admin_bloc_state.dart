part of 'admin_bloc_bloc.dart';

@immutable
abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AgentsLoading extends AdminState {}

class AgentOperationSuccess extends AdminState {
  final Iterable<User> agents;

  AgentOperationSuccess([this.agents = const []]);

  @override
  List<Object> get props => [agents];
}

class AgentOperationFailure extends AdminState {}
