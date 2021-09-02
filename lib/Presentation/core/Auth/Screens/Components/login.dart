import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/alreadyHaveAnAccount.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/roundedBtn.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/textFieldContainer.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/SignUP/signup.dart';

import 'RoundedPasswordField.dart';
import 'loginBody.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Body(
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        SvgPicture.asset(
          "assets/images/Drug.svg",
          height: size.height * 0.3,
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        RoundedInputField(
          hintText: "Username",
          onChanged: (value) {},
        ),
        RoundedPasswordField(onChanged: (value) {}),
        SizedBox(
          height: size.height * 0.04,
        ),
        RoundedButton(text: "LOGIN", pressed: () {}),
        SizedBox(
          height: size.height * 0.04,
        ),
        AlreadyHaveAnAccount(
          pressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SignUp();
            }));
          },
        )
      ])),
    ));
  }
}
