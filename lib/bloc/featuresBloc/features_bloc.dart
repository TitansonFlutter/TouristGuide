import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/Presentation/Models/review_model.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/repository/features_repository.dart';

part 'features_event.dart';
part 'features_state.dart';

class FeaturesBloc extends Bloc<FeaturesEvent, FeaturesState> {
  FeaturesRepository featuresRepository;
  FeaturesBloc(this.featuresRepository) : super(ToursLoading());

  @override
  Stream<FeaturesState> mapEventToState(
    FeaturesEvent event,
  ) async* {
    if (event is LoadTours) {
      yield ToursLoading();
      try {
        final tours = await featuresRepository.fetchAllTours();
        yield FeaturesOperationSuccess(tours);
      } catch (e) {
        yield FeaturesOperationFailure();
      }
    }
    if (event is LoadReviews) {
      yield ToursLoading();
      try {
        final book = await featuresRepository.bookStatus(event.uId, event.tId);
        yield BookStatusSuccess(book);
        final reviews = await featuresRepository.fetchAllReviews(event.tId);
        yield ReviewOperationSuccess(reviews);
      } catch (e) {
        yield FeaturesOperationFailure();
      }
    }
  }
}
