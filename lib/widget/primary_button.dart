import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  Color color;
  String text;
  Function onBtnPressed;

  PrimaryButton(
      {@required this.color, @required this.text, @required this.onBtnPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onBtnPressed,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(text,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
    );
  }
}
