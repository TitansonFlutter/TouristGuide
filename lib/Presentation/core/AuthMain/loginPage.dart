import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/RoundedPasswordField.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/roundedBtn.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/textFieldContainer.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/title.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/constants.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/signup.dart';
import 'package:tourist_guide_app/bloc/auth_bloc.dart';

import 'Widget/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = "/login";

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hiddenPassword = true;

  Widget _backButton() {
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

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
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
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    TitleName(),
                    SizedBox(height: 50),
                    TextFieldContainer(child: _emailField()),
                    RoundedPasswordField(
                      onChanged: null,
                      passwordController: passwordTextController,
                    ),
                    SizedBox(height: 20),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (ctx, authState) {
                        if (authState is AuthSuccess) {
                          print(authState.user);
                          Navigator.pushNamed(context, '/home');
                        }
                      },
                      builder: (ctx, authState) {
                        Widget buttonChild = RoundedButton(
                          text: "Login",
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          pressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            final authBloc = BlocProvider.of<AuthBloc>(context);

                            authBloc.add(LogInEvent(emailTextController.text,
                                passwordTextController.text));
                          },
                        );
                        if (authState is AuthInProgress) {
                          buttonChild = CircularProgressIndicator(
                            color: Colors.blue,
                          );
                        }
                        if (authState is AuthError) {
                          print("AuthError");
                          try {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(authState.errMsg)));
                          } catch (e) {
                            print(e);
                          }
                        }

                        return Container(child: buttonChild);
                      },
                    ),
                    SizedBox(height: height * .055),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    ));
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
