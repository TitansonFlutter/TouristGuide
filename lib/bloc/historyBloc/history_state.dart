part of 'history_bloc.dart';


abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class UpcomingState extends HistoryState {
  final Iterable<Tour> tours;

  UpcomingState(this.tours);
  @override
  List<Object> get props => [];
}

class PastState extends HistoryState {
  final Iterable<Tour> tours;

  PastState([this.tours = const []]);
  @override
  List<Object> get props => [tours];
}

class HistoryFailure extends HistoryState {
  final String txt;
  HistoryFailure(this.txt);
  @override
  List<Object> get props => [];
}
