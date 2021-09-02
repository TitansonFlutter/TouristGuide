import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'filterbloc_event.dart';
part 'filterbloc_state.dart';

class FilterblocBloc extends Bloc<FilterblocEvent, FilterblocState> {
  // final FilterRepository tourRepository;

  FilterblocBloc() : super(FilterblocInitial());

  @override
  Stream<FilterblocState> mapEventToState(
    FilterblocEvent event,
  ) async* {
// Filter mapping
    // if (event is FetchAllTours) {
    //   // loading code
    //   yield Loading();
    //   final tours = await tourRepository.fetchAllTours();
    //   yield AllToursFetched(tours); //tours are to be replaced with the place
    // }

    // if (event is FetchTourByName) {
    //   // loading code
    //   yield Loading();
    //   final tours = await tourRepository.fetchTourByName(event.TourName);
    //   yield TourByNameFetched(tours);
    // }

    // if (event is Filter) {
    //   // loading code
    //   yield Loading();
    //   final tours = await tourRepository.filter(event.filters);
    //   yield TourByNameFetched(tours);
    // }
  }
}
