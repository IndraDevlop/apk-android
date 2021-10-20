import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:biznet/widget/user_caraousel.dart';
import 'package:biznet/widget/user_marketing_list_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'marketingUser/marketing_user.dart';

class HomeUser extends StatefulWidget {
  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final String welcome = 'Welcome';

  String uid = '';
  String name = '';
  String phone = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: Center(
          child: Container(
           height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // height: 640,
            // width: 360,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"), fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 85,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/logo.png"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PrimaryText(text: welcome),
                                      PrimaryText(text: name),
                                      SizedBox(height: 5),
                                      SecondaryText(
                                          text: '+62' + phone,
                                          color: Colors.black,
                                          size: 14),
                                      SecondaryText(
                                          text: email,
                                          color: Colors.black,
                                          size: 14),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/profileuser');
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icon_profile.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 5),
                  UserCaraousel(),
                  SizedBox(height: 5),
                  Container(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.height,
                          minHeight: 25.0),
                      child: UserMarketingListWidget()),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    String email = prefs.getString('email');
    print(email);
    final Firestore firestore = Firestore.instance;
    firestore.collection("users").document(uid).get().then((value) {
      print(value.data);
      print(value.data["name"].toString());
      print(value.data["phone"].toString());
      setState(() {
        name = value.data["name"].toString();
        phone = value.data["phone"].toString();
        email = value.data["email"].toString();
      });
    });
  }
}
