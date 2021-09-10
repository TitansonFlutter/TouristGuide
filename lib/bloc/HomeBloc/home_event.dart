import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadingRecommended extends HomeEvent {
  const LoadingRecommended();

  @override
  List<Object> get props => [];
}



class LoadedRecommended extends HomeEvent {
  final Tour places;

  const LoadedRecommended(this.places);

  @override
  List<Object> get props => [places];
}

