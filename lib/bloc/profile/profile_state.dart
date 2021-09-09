part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final User user;
  ProfileSuccess(this.user);

  @override
  List<Object> get props => [];
}

class EditProfileFailure extends ProfileState {}
