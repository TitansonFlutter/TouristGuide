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
  Stream<AuthState> mapEventToState(AuthEvent event) async* {}
}
