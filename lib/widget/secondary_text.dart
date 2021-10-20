import 'package:biznet/widget/utils/const.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SecondaryText extends StatelessWidget {
  String text;
  Color color;
  double size;
  

  SecondaryText(
      {@required this.text, @required this.color, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
     
    );
  }
}