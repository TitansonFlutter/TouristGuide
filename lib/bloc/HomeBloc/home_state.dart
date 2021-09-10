import 'package:equatable/equatable.dart';


class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}
class HomeInitial extends HomeState{}


class RecomendedLoading extends HomeState {}

class RecomendedLoadSuccess extends HomeState {
  final List<Tour> places;

  RecommendedLoadSuccess([this.places = const []]);

  @override
  List<Object> get props => [Tour];
}

class HomeOperationFailure extends HomeState {}
