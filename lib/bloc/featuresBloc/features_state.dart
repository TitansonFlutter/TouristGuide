part of 'features_bloc.dart';

abstract class FeaturesState extends Equatable {
  const FeaturesState();

  @override
  List<Object> get props => [];
}

class ToursLoading extends FeaturesState {}

class FeaturesOperationSuccess extends FeaturesState {
  final Iterable<Tour> tours;

  FeaturesOperationSuccess([this.tours = const []]);

  @override
  List<Object> get props => [tours];
}

class ReviewOperationSuccess extends FeaturesState {
  final Iterable<Review> reviews;

  ReviewOperationSuccess([this.reviews = const []]);

  @override
  List<Object> get props => [reviews];
}

class AddReviewSuccess extends FeaturesState {
  final Review review;

  AddReviewSuccess(this.review);

  @override
  List<Object> get props => [review];
}

class BookStatusSuccess extends FeaturesState {
  final User user;

  BookStatusSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class BookSuccess extends FeaturesState {
  final User user;

  BookSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class FeaturesOperationFailure extends FeaturesState {}
