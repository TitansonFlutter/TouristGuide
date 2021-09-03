part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class logIn extends AuthEvent {
  final String email;
  final String password;
  logIn(this.email, this.password);
}
