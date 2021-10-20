import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_screen.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final String username = 'ditya';
  final String phoneNumber = '081292921433';
  final String welcome = 'Welcome Admin';
  final String version = 'Version';
  final String versionNumber = '1.8.2';

  final String createPackageLabel = 'Create Package';
  final String createMarketingLabel = 'Create Marketing';
  final String transactionLabel = 'Transaction';
  final String listLabel = 'Package and Marketing';
  final String logoutLabel = 'Logout';

  String uid = '';
  String name = '';
  String phone = '';

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
                                        image: AssetImage("assets/logo.png"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      PrimaryText(text: welcome),
                                      PrimaryText(text: name),
                                      SizedBox(height: 5),
                                      SecondaryText(
                                          text: '+62' + phone,
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
                                Navigator.of(context).pushNamed('/profileadmin');
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/icon_profile.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 20),
                  Container(
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Create Package
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/packagecreate');
                            },
                            child: Container(
                              width: 345,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/icon_package.png"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    child: SecondaryText(
                                        text: createPackageLabel,
                                        color: primaryColour,
                                        size: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //End create package

                          SizedBox(height: 20),

                          //Create Marketing
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/marketingcreate');
                            },
                            child: Container(
                              width: 345,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/icon_marketing.png"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    child: SecondaryText(
                                        text: createMarketingLabel,
                                        color: primaryColour,
                                        size: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //End create marketing
                          SizedBox(height: 20),

                          //Transaction
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/transaction');
                            },
                            child: Container(
                              width: 345,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/icon_transaction.png"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    child: SecondaryText(
                                        text: transactionLabel,
                                        color: primaryColour,
                                        size: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //End transaction
                          SizedBox(height: 20),

                          //List Package and Marketing
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/packagemarketing');
                            },
                            child: Container(
                              width: 345,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage("assets/icon_list.png"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    child: SecondaryText(
                                        text: listLabel,
                                        color: primaryColour,
                                        size: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //End list
                          SizedBox(height: 20),

                          //Logout
                          GestureDetector(
                            onTap: () {
                              logout();
                            },
                            child: Container(
                              width: 345,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/icon_logout.png"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Container(
                                    child: SecondaryText(
                                        text: logoutLabel,
                                        color: primaryColour,
                                        size: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                           //End logout
                        
                         
                        ],
                      )),
                  SizedBox(height: 80),
                  Container(
                    child: PrimaryText(
                      text: version + ' ' + versionNumber,
                    ),
                  ),
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

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    final Firestore firestore = Firestore.instance;
    firestore.collection("users").document(uid).get().then((value) {
      print(value.data);
      print(value.data["name"].toString());
      print(value.data["phone"].toString());
      setState(() {
        name = value.data["name"].toString();
        phone = value.data["phone"].toString();
      });
    });
  }
}
