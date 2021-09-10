import 'package:flutter/material.dart';

import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/textFieldContainer.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController passwordController;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.passwordController,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextFormField(
      obscureText: hidePassword,
      onChanged: widget.onChanged,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        } else if (value.length < 6) {
          return 'Password too short';
        }
        return null;
      },
      controller: widget.passwordController,
      decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: FlatButton.icon(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            icon: Icon(Icons.visibility),
            label: Text(""),
          ),
          border: InputBorder.none),
    ));
  }
}
