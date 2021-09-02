import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/login.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/roundedBtn.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/styles/textStyles.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/constants.dart';
import './background.dart';

class LogInBody extends StatelessWidget {
  const LogInBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //provide total screen size
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              welcomeScreenAppName,
              style: WelcomeTitleStyle(),
            ),
            SizedBox(
              height: size.height * heightBetweeenWidgetsSmall,
            ),
            SizedBox(
              height: size.height * heightBetweeenWidgetsSmall,
            ),
            SvgPicture.asset(
              "icons/MountainScene.svg",
              height: size.height * heightBetweeenWidgetsMedium,
            ),
            SizedBox(
              height: size.height * heightBetweeenWidgetsSmall,
            ),
            RoundedButton(
              text: "LOGIN",
              pressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            ),
            SizedBox(
              height: 4,
            ),
            RoundedButton(
              text: "SIGNUP",
              textColor: Colors.white,
              color: kPrimarySecondColor,
              pressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
