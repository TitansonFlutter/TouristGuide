import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/repository/auth_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepo;
  ProfileBloc(this.authRepo) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is EditProfile) {
      try {
        final result = await authRepo.updateProfile(event.user, 1);
        print(result);
        yield ProfileSuccess(result);
      } catch (e) {
        yield EditProfileFailure();
      }
    }
  }
}
