import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourist_guide_app/repository/features_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FeaturesRepository tourRepository;
  AuthBloc(this.tourRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    // Filter mapping
    // if (event is FetchAllTours) {
    //   // loading code
    //   yield Loading();
    //   final tours = await tourRepository.fetchAllTours();
    //   yield AllToursFetched(tours);
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
