import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;

  AuthBloc(this.authRepo) : super(LoggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LogInEvent) {
      yield AuthInProgress();
      final email = event.email;
      final password = event.password;

      final user = User(email, "username", 0, password);

      try {
        final result = await authRepo.login(user);
        yield AuthSuccess(result);
      } on SocketException catch (_) {
        yield AuthError(errMsg: "Check your internet connection");
      } catch (e) {
        yield AuthError(errMsg: e.toString());
        await Future.delayed(Duration(seconds: 2));
        yield LoggedOut();
      }
    }
    if (event is SignUp) {
      yield AuthInProgress();
      final email = event.email;
      final username = event.username;

      final password = event.password;

      final user = User(email, username, 0, password);

      try {
        final result = await authRepo.signup(user);
        yield AuthSuccess(result);
      } on SocketException catch (_) {
        yield AuthError(errMsg: "Check your internet connection");
      } catch (e) {
        yield AuthError(errMsg: e.toString());
        await Future.delayed(Duration(seconds: 2));
        yield LoggedOut();
      }
    }
  }
}
