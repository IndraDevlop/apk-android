import 'package:biznet/widget/utils/const.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegularText extends StatelessWidget {
  String text;
  Color color;
  double size;

  RegularText({@required this.text, @required this.color, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}
