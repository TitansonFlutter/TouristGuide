import 'package:flutter/material.dart';
import 'package:tourist_guide_app/AuthDb.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/roundedBtn.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/title.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/Component/topGradient.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/loginPage.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/signup.dart';
import 'package:tourist_guide_app/appConstants.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[],
          ),
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: SecondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: SecondaryColor, width: 2),
              ),
              child: RoundedButton(
                text: "Login",
                color: SecondaryColor,
              ))),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: SecondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(80)),
            border: Border.all(color: SecondaryColor, width: 2),
          ),
          child: RoundedButton(
            text: "Register",
            color: SecondaryColor,
          )),
    );
  }

  Widget _title() {
    return TitleName();
  }

  @override
  Widget build(BuildContext context) {
    getuser() async {
      try {
        final user = await SaveUsersDb.instance.readUser();
        return user;
      } catch (e) {
        print("ERROR OCCURED :" + e);
      }
    }

    print("USER RETRIEVED");
    print(getuser().then((value) => value.username));
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
                height: 40,
              ),
              _submitButton(),
              SizedBox(
                height: 20,
              ),
              _signUpButton(),
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
