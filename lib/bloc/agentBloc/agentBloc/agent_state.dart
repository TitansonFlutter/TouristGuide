part of 'agent_bloc.dart';

abstract class AgentState extends Equatable {
  const AgentState();

  @override
  List<Object> get props => [];
}

class TourLoading extends AgentState {}

class TourOperationSuccess extends AgentState {
  final Iterable<Tour> tours;

  TourOperationSuccess([this.tours = const []]);

  @override
  List<Object> get props => [tours];
}

class TourOperationFailure extends AgentState {}
