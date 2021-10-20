import 'package:biznet/widget/utils/const.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class UserCaraousel extends StatelessWidget {
  @override
 @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
                  child: SizedBox(
            height:120.0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Carousel(
                boxFit: BoxFit.cover,
                autoplay: true,
                animationCurve: Curves.fastOutSlowIn,
                animationDuration: Duration(milliseconds: 1000),
                dotSize: 6.0,
                dotIncreasedColor: primaryColour,
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.topRight,
                dotVerticalPadding: 10.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                images: [
                  ExactAssetImage("assets/slide_1.jpg"),
                  ExactAssetImage("assets/slide_2.jpg"),
                  ExactAssetImage("assets/slide_3.jpg"),
                  ExactAssetImage("assets/slide_4.jpg"),
                  ExactAssetImage("assets/slide_5.jpg"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}