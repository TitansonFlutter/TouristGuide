import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/roundedBtn.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/topGradient.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/loginPage.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/signup.dart';

// class WelcomePage extends StatefulWidget {
//   WelcomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _WelcomePageState createState() => _WelcomePageState();
// }

class WelcomePage extends StatelessWidget {
  Widget _submitButton(context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(LoginPage.routeName);
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[],
          ),
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 13),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: RoundedButton(
                text: "Login",
              ))),
    );
  }

  Widget _signUpButton(context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(SignUpPage.routeName);
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: RoundedButton(
            text: "Register",
          )),
    );
  }

  // Widget _label() {
  //   return Container(
  //       margin: EdgeInsets.only(top: 40, bottom: 20),
  //       child: Column(
  //         children: <Widget>[
  //           Text(
  //             'Quick login with Touch ID',
  //             style: TextStyle(color: Colors.white, fontSize: 17),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Icon(Icons.fingerprint, size: 90, color: Colors.white),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Text(
  //             'Touch ID',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 15,
  //               decoration: TextDecoration.underline,
  //             ),
  //           ),
  //         ],
  //       ));
  // }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'T',
          style: TextStyle(color: Colors.white, fontSize: 30),
          children: [
            TextSpan(
              text: 'our',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'vago',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: topGradient()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 80,
              ),
              _submitButton(context),
              SizedBox(
                height: 20,
              ),
              _signUpButton(context),
              SizedBox(
                height: 20,
              ),
              // _label()
            ],
          ),
        ),
      ),
    );
  }
}
