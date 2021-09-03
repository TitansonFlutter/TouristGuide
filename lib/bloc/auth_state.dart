part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class LoggedIn extends AuthState {}

class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String errMsg;
  AuthError({this.errMsg, String errorMsg});
}
