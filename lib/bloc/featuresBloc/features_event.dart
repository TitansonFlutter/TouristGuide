part of 'features_bloc.dart';

abstract class FeaturesEvent extends Equatable {
  const FeaturesEvent();

  @override
  List<Object> get props => [];
}

class LoadTours extends FeaturesEvent {
  const LoadTours();
}

class LoadReviews extends FeaturesEvent {
  final int tId;
  final int uId;
  const LoadReviews(this.tId, this.uId);
  @override
  List<Object> get props => [tId, uId];

  @override
  String toString() => "Tour Id: $tId}";
}

class AddReview extends FeaturesEvent {
  final Review review;

  const AddReview(this.review);

  @override
  List<Object> get props => [review];

  @override
  String toString() => "User Add {review: $review}";
}
