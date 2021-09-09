part of 'filterbloc_bloc.dart';

@immutable
abstract class FilterblocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

//Filter events

class FetchAllTours extends FilterblocEvent {}

class FetchTourByName extends FilterblocEvent {
  final String Tourname;
  FetchTourByName(this.Tourname);
}

class FetchDescrition extends FilterblocEvent {
  final String TourId;
  FetchDescrition(this.TourId);
}

class Filter extends FilterblocEvent {
  final double priceHigh;
  final double priceLow;
  final String tourName;
  Filter(this.priceHigh, this.priceLow, this.tourName);
}
