import 'package:flutter/material.dart';

Widget TitleName() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'T',
        style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
        children: [
          TextSpan(
            text: 'our',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: 'vago',
            style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
          ),
        ]),
  );
}
