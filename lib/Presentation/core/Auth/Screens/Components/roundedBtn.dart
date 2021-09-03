import 'package:flutter/material.dart';
import '../../constants.dart';

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
        borderRadius: BorderRadius.circular(80),
        child: FlatButton(
          onPressed: pressed,
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          color: color,
        ),
      ),
    );
  }
}
