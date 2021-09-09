part of 'filterbloc_bloc.dart';

@immutable
abstract class FilterblocState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilterblocInitial extends FilterblocState {}

//States for the filter page
class Loading extends FilterblocState {}

class AllToursFetched extends FilterblocState {
  final List<Tour> tours;
  AllToursFetched(this.tours);

  @override
  List<Object> get props => [tours];
}

class TourByNameFetched extends FilterblocState {
  final List<Tour> tours;
  TourByNameFetched(this.tours);
}

class FilteredTours extends FilterblocState {
  final List<Tour> tours;
  FilteredTours(this.tours);
}

class DescriptionFetched extends FilterblocState {
  final Tour tour;
  DescriptionFetched(this.tour);
}

class Error extends FilterblocState {
  final String errorMsg;
  Error(this.errorMsg);
}
