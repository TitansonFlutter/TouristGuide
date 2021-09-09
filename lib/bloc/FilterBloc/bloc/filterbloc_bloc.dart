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

      yield AllToursFetched(tours); //tours are to be replaced with the place
    }

    if (event is FetchTourByName) {
      // loading code
      yield Loading();

      if (event.Tourname.isEmpty || event.Tourname == null) {
        final tours = await tourRepository.fetchAllTours();

        yield AllToursFetched(tours);
      } else {
        try {
          final List<Tour> tour =
              await tourRepository.fetchTourByName(event.Tourname);
          yield TourByNameFetched(tour);
        } catch (e) {
          yield Error(e.toString());
        }
      }
    }

    if (event is Filter) {
      // loading code
      yield Loading();
      List<String> filters = [
        event.priceHigh.toString(),
        event.priceLow.toString(),
        event.tourName.toString()
      ];
      final tours = await tourRepository.filter(filters);
      yield FilteredTours(tours);
    }
  }
}
