import 'package:biznet/widget/utils/const.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PrimaryText extends StatelessWidget {
  String text;
  

  PrimaryText(
      {@required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(color: primaryColour, fontSize: 22, fontWeight: FontWeight.bold),
     
    );
  }
}