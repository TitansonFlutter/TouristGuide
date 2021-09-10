import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/repository/filter_repository.dart';

part 'filterbloc_event.dart';
part 'filterbloc_state.dart';

class FilterblocBloc extends Bloc<FilterblocEvent, FilterblocState> {
  final FilterRepository tourRepository;

  FilterblocBloc(this.tourRepository) : super(FilterblocInitial());

  @override
  Stream<FilterblocState> mapEventToState(
    FilterblocEvent event,
  ) async* {
// Filter mapping

    if (event is FetchAllTours) {
      // loading code
      yield Loading();
      final tours = await tourRepository.fetchAllTours();
      try {
        yield AllToursFetched(tours); //tours are to be replaced with the place
      } catch (e) {
        yield Error(e.toString());
      }
    }

    if (event is FetchTourByName) {
      yield Loading();
      if (event.tourname.isEmpty || event.tourname == null) {
        try {
          final tours = await tourRepository.fetchAllTours();
          yield AllToursFetched(tours);
        } catch (e) {
          yield Error(e.toString());
        }
      } else {
        try {
          final List<Tour> tour =
              await tourRepository.fetchTourByName(event.tourname);
          yield TourByNameFetched(tour);
        } catch (e) {
          yield Error(e.toString());
        }
      }
    }
    if (event is Filter) {
      List<dynamic> filters;
      yield Loading();
      try {
        filters = [event.priceHigh, event.priceLow, event.tourName];
        final tours = await tourRepository.filter(filters);
        yield FilteredTours(tours);
      } catch (e) {
        yield Error(e.toString());
      }
    }
  }
}
