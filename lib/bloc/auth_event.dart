part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LogInEvent extends AuthEvent {
  final String email;
  final String password;
  LogInEvent(this.email, this.password);
}

class SignUp extends AuthEvent {
  final String email;
  final String username;
  final String password;

  SignUp(this.email, this.username, this.password);
}
