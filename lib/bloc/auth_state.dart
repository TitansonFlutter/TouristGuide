part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInProgress extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(@required this.user);
  @override
  List<Object> get props => [user];
}

class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String errMsg;
  AuthError({this.errMsg});
}
