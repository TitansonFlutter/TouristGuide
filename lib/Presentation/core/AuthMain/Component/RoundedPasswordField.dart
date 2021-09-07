import 'package:flutter/material.dart';

import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/textFieldContainer.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController passwordController;
  final bool hidePassword;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hidePassword = true,
    this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      obscureText: hidePassword,
      onChanged: onChanged,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        } else if (value.length < 6) {
          return 'Password too short';
        }
        return null;
      },
      controller: passwordController,
      decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.visibility),
            label: Text(""),
          ),
          border: InputBorder.none),
    ));
  }
}
