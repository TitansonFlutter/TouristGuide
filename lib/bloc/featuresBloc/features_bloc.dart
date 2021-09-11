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
        // print(event.tId);
        // print(event.uId);
        final book = await featuresRepository.bookStatus(event.uId, event.tId);
        yield BookStatusSuccess(book);
        final reviews = await featuresRepository.fetchAllReviews(event.tId);
        yield ReviewOperationSuccess(reviews);
      } catch (e) {
        yield FeaturesOperationFailure();
      }
    }
    if (event is Book) {
      yield ToursLoading();
      try {
        final booked = await featuresRepository.book(event.uId, event.tId);
        yield BookSuccess(booked);
      } catch (e) {
        yield FeaturesOperationFailure();
      }
    }
    if (event is AddReview) {
      yield ToursLoading();
      try {
        final reviewed = await featuresRepository.addReview(event.review);
        yield AddReviewSuccess(reviewed);
      } catch (e) {
        yield FeaturesOperationFailure();
      }
    }
  }
}
