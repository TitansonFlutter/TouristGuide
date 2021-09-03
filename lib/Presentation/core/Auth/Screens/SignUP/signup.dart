import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/RoundedPasswordField.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/SocialMediaIcons.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/alreadyHaveAnAccount.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/loginBody.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/roundedBtn.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/textFieldContainer.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUPBody(),
    );
  }
}

class SignUPBody extends StatelessWidget {
  const SignUPBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Body(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "SIGN UP",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SvgPicture.asset(
            "assets/images/stethoscope.svg",
            width: size.width * 0.3,
          ),
          RoundedInputField(hintText: "Your Email", onChanged: (value) {}),
          RoundedPasswordField(onChanged: (value) {}),
          SizedBox(
            height: size.height * 0.04,
          ),
          RoundedButton(
              text: "SIGN UP",
              pressed: () {
                Navigator.pushNamed(context, "/login");
              }),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAnAccount(loggedIn: false, pressed: () {}),
          SizedBox(
            height: size.height * 0.04,
          ),
          OrDivider(),
          SizedBox(
            height: size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialMediaIcons(
                iconSrc: "assets/icons/facebook.svg",
                pressed: () {},
              ),
              SocialMediaIcons(
                iconSrc: "assets/icons/twitter.svg",
                pressed: () {},
              ),
              SocialMediaIcons(
                iconSrc: "assets/icons/google-plus.svg",
                pressed: () {},
              ),
            ],
          )
        ]),
      ),
    );
  }
}
