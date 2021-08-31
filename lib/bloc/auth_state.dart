part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Loading extends AuthState {}


//States for the filter page


// class AllToursFetched extends AuthState {
//   final List<Tour> tours;
//   AllToursFetched(this.tours);
// }

// class TourByNameFetched extends AuthState {
//   final Tour tour;
//   TourByNameFetched(this.tour);
// }

// class FilteredTours extends AuthState {
//   final List<Tour> tours;
//   FilteredTours(this.tours);
// }
