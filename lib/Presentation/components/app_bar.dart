import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:travel_app/constants.dart';

AppBar buildAppBar(BuildContext context,
    {@required String title,
    @required List<Widget> actions,
    @required Widget leading}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(
          // color: kTextColor,
          color: Color(0XFF2C2C2C),
          fontSize: 27),
    ),
    leading: leading,
    actions: actions,
  );
}
