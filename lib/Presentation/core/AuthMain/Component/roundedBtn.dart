import 'package:flutter/material.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() pressed;
  final Color color, textColor;

  const RoundedButton({
    Key key,
    this.text,
    this.pressed,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlatButton(
          onPressed: pressed,
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 20),
          ),
          color: color,
        ),
      ),
    );
  }
}
