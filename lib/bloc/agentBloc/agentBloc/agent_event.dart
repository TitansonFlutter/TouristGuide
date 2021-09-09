part of 'agent_bloc.dart';

abstract class AgentEvent extends Equatable {
  const AgentEvent();

  @override
  List<Object> get props => [];
}

class ToursLoad extends AgentEvent {
  final int aId;
  const ToursLoad(this.aId);

  @override
  List<Object> get props => [aId];

  @override
  String toString() => "Tour Created {Agent: $aId}";
}

class CreateTour extends AgentEvent {
  final int aId;
  final Tour tour;
  const CreateTour(this.aId, this.tour);

  @override
  List<Object> get props => [aId, tour];

  @override
  String toString() => "Tour Created {Agent: $aId, Tour: $tour}";
}

class UpdateTour extends AgentEvent {
  final int aId;
  final int tId;
  final Tour tour;
  const UpdateTour(this.aId, this.tId, this.tour);

  @override
  List<Object> get props => [aId, tId, tour];

  @override
  String toString() => "Tour Updated {Agents: $aId, TourId: $tId, Tour: $tour}";
}

class DeleteTour extends AgentEvent {
  final int aId;
  final int tId;
  const DeleteTour(this.aId, this.tId);
  @override
  List<Object> get props => [aId, tId];

  @override
  String toString() => "Tour Deleted {Agent: $aId, Tour: $tId}";
}
