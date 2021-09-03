import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/repository/auth_repository.dart';

import 'package:tourist_guide_app/repository/features_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;

  AuthBloc(this.authRepo) : super(LoggedOut());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is logIn) {
      yield Loading();
      final email = event.email;
      final password = event.password;

      final user = User(email, "username", 0, password);
      try {
        final result = await authRepo.login(user);
        print(result);
        print("///////////////////////////////");
      } catch (e) {
        print(e);
      }
      // ;
      // if (username == "com") {
      //   if (password == "123456") {
      //     // login successfuly
      //     yield LoggedIn();
      //   } else {
      //     // wrong password
      //     yield AuthError(errorMsg: 'Wrong password');
      //   }
      // } else {
      //   // account doesn't exists
      //   yield AuthError(errorMsg: 'Account does not exist');
      // }
    }
  }
}
