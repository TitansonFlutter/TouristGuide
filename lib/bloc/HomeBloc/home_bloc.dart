import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/bloc/bloc.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc (this.homeRepository)
      : assert(homeRepository != null),
        super(RecomendedLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadingRecommended) {
      yield RecomendedLoading();
      try {
        final places = await homeRepository.getRecommended();
        yield RecomendedLoadSuccess(places);
      } catch (_) {
        yield HomeOperationFailure();
      }
    }
   
}
