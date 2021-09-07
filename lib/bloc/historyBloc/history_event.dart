part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class UpcomingEvent extends HistoryEvent {
  final int id;
  // final Tour tour;
  UpcomingEvent(this.id);

  @override
  List<Object> get props => [id];
}

class PastEvent extends HistoryEvent {
  final int id;
  // final Tour tour;
  PastEvent(this.id);

  @override
  List<Object> get props => [id];
}
