import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/repository/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository historyRepository;

  HistoryBloc(this.historyRepository) : super(HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is UpcomingEvent) {
      try {
        final tours = await historyRepository.fetchAllUpcomingHistory(event.id);
        yield UpcomingState(tours);
      } catch (e) {
        yield HistoryFailure("Error");
      }
    }
    if (event is PastEvent) {
      try {
        final tours = await historyRepository.fetchAllPastHistory(event.id);

        yield PastState(tours);
      } catch (e) {
        yield HistoryFailure("Error");
      }
    }
  }
}