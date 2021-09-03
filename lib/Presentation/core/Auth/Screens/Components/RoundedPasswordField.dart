import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/textFieldContainer.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController passwordController;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: true,
      onChanged: onChanged,
      controller: passwordController,
      decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none),
    ));
  }
}
