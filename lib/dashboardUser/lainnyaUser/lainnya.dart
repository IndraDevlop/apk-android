import 'package:biznet/widget/primary_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../login_screen.dart';

class Lainnya extends StatefulWidget {
  @override
  _LainnyaState createState() => _LainnyaState();
}

class _LainnyaState extends State<Lainnya> {
  final String _callCenter = 'Call Center';
  final String _about = 'About';
  final String _logout = 'Logout';

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
          child: Center(
              child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                height: 160,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/logo.png"), fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 50),
              Divider(),
              SizedBox(height: 10),
              Container(
                width: 200,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        launchWhatsApp();
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/icon_phone.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              child: PrimaryText(text: _callCenter),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/about');
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/icon_about.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              child: PrimaryText(text: _about),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        logout();
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/icon_logout.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 15),
                            Container(
                              child: PrimaryText(text: _logout),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  void logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    auth.signOut().then((res) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false);
    });
  }

  launchWhatsApp() async {
  final link = WhatsAppUnilink(
    phoneNumber: '+6281311128448',
    text: "Terimakasih telah menghubungi admin, kami akan merespon secepat mungkin",
  );
  await launch('$link');
}
}
