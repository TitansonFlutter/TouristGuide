part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

//Filter events

class FetchAllTours extends AuthEvent {}

class FetchTourByName extends AuthEvent {
  final String tourName;
  FetchTourByName(this.tourName);
}

class Filter extends AuthEvent {
  final List<String> filters;
  Filter(this.filters);
}
