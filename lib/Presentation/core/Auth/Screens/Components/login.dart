import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/alreadyHaveAnAccount.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/roundedBtn.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/textFieldContainer.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/SignUP/signup.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/styles/textStyles.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/constants.dart';
import 'package:tourist_guide_app/bloc/auth_bloc.dart';

import 'RoundedPasswordField.dart';
import 'loginBody.dart';

class LoginScreen extends StatefulWidget {
  static final String routeName = '/login';
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
        body: Body(
      child: Form(
        key: formKey,
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            welcomeScreenAppName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          SvgPicture.asset(
            "images/Drug.svg",
            height: size.height * 0.3,
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          RoundedInputField(
            hintText: "Email",
            onChanged: (value) {},
            emailController: emailController,
          ),
          RoundedPasswordField(
            onChanged: (value) {},
            passwordController: passwordController,
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          RoundedButton(
              text: "LOGIN",
              pressed: () {
                authBloc.add(
                  logIn(emailController.text, passwordController.text),
                );
                if (AuthState is LoggedIn) {
                  print("LOggedIN");
                }
                ;
              }),
          // BlocListener(listener: (_, authState) {
          //   if (authState is LoggedIn) {
          //     print('loggedIn');
          //   }
          // }),
          SizedBox(
            height: size.height * 0.04,
          ),
          AlreadyHaveAnAccount(
            pressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SignUpPage();
              }));
            },
          )
        ])),
      ),
    ));
  }
}
