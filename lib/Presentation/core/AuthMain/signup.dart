import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/RoundedPasswordField.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/roundedBtn.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/textFieldContainer.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/title.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Widget/bezierContainer.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/constants.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/loginPage.dart';
import 'package:tourist_guide_app/bloc/auth_bloc.dart';

// class SignUpPage extends StatefulWidget {
//   SignUpPage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

class SignUpPage extends StatelessWidget {
  static final String routeName = "/signup";

  final usernameTextController = TextEditingController();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Widget _backButton(context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _loginAccountLabel(context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      TitleName(),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedInputField(
                        hintText: "Username",
                        controller: usernameTextController,
                      ),
                      TextFieldContainer(
                        child: _emailField(),
                      ),
                      RoundedPasswordField(
                        onChanged: null,
                        passwordController: passwordTextController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (ctx, authState) {
                          print(authState);
                          if (authState is AuthSuccess) {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Successfully created")));
                            } catch (e) {}
                            Navigator.pushNamed(context, '/login');
                          }
                        },
                        builder: (ctx, authState) {
                          Widget buttonChild = RoundedButton(
                            text: "Register",
                            color: kPrimaryColor,
                            textColor: Colors.white,
                            pressed: () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              final authBloc =
                                  BlocProvider.of<AuthBloc>(context);

                              authBloc.add(SignUp(
                                  emailTextController.text,
                                  usernameTextController.text,
                                  passwordTextController.text));
                            },
                          );
                          if (authState is AuthInProgress) {
                            buttonChild = CircularProgressIndicator(
                              color: Colors.blue,
                            );
                          }
                          if (authState is AuthError) {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(authState.errMsg)));
                            } catch (e) {}
                          }

                          return Container(child: buttonChild);
                        },
                      ),
                      SizedBox(height: height * .14),
                      _loginAccountLabel(context),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: emailTextController,
      decoration: InputDecoration(
        icon: Icon(
          Icons.person,
          color: kPrimaryColor,
        ),
        hintText: "Email",
        border: InputBorder.none,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
    );
  }
}
