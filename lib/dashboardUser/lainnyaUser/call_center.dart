import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:flutter/material.dart';

class CallCenter extends StatefulWidget {
  @override
  _CallCenterState createState() => _CallCenterState();
}

class _CallCenterState extends State<CallCenter> {
  final String _callCenterLabel =
      'if you have question about our services, package, or etc. Call center will help to fix your problem';

  final String _phoneCallCenter = '1500200';
  final String _biznetCallCenter = 'BizNet Call Center';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
           height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // height: 640,
        // width: 360,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                height: 100,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/logo.png"), fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 40),
              Container(
                  width: 250,
                  height: 300,
                  child: Column(
                    children: [
                      Text(
                        _callCenterLabel,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColour,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          children: [
                            Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/icon_phone.png"),
                                      fit: BoxFit.cover),
                                )),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: SecondaryText(
                                    text: _biznetCallCenter,
                                    color: primaryColour,
                                    size: 16,
                                  ),
                                ),
                                Container(
                                  child: SecondaryText(
                                    text: _phoneCallCenter,
                                    color: primaryColour,
                                    size: 16,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
