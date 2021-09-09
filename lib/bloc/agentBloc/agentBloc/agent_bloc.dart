import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/repository/agentRepository/agentRepository/agent_repository.dart';

part 'agent_event.dart';
part 'agent_state.dart';

class AgentBloc extends Bloc<AgentEvent, AgentState> {
  final AgentRepository agentRepository;
  AgentBloc(this.agentRepository) : super(TourLoading());

  @override
  Stream<AgentState> mapEventToState(
    AgentEvent event,
  ) async* {
    if (event is ToursLoad) {
      yield TourLoading();
      try {
        final tours = await agentRepository.fetchAllTours(event.aId);
        yield TourOperationSuccess(tours);
      } catch (e) {
        yield TourOperationFailure();
      }
    }
    if (event is CreateTour) {
      try {
        await agentRepository.addTour(event.aId, event.tour);
        final tours = await agentRepository.fetchAllTours(event.aId);
        yield TourOperationSuccess(tours);
      } catch (_) {
        yield TourOperationFailure();
      }
    }
    if (event is UpdateTour) {
      try {
        await agentRepository.updateTour(event.aId, event.tId, event.tour);
        final tours = await agentRepository.fetchAllTours(event.aId);
        yield TourOperationSuccess(tours);
      } catch (_) {
        yield TourOperationFailure();
      }
    }
    if (event is DeleteTour) {
      try {
        await agentRepository.deleteTour(event.aId, event.tId);
        final tours = await agentRepository.fetchAllTours(event.aId);
        yield TourOperationSuccess(tours);
      } catch (_) {
        yield TourOperationFailure();
      }
    }
  }
}
