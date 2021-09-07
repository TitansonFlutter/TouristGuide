import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/constants.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  final bool loggedIn;
  final void Function() pressed;
  const AlreadyHaveAnAccount({
    Key key,
    this.loggedIn = true,
    this.pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          loggedIn ? "Don't have an account ? " : "Already have account ?",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: pressed,
          child: Text(
            loggedIn ? "Sign up" : "Sign In",
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
