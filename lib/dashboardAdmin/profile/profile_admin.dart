import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileAdmin extends StatefulWidget {
  @override
  _ProfileAdminState createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  final String title = 'Profile Admin';

  final String nameLabel = 'Admin Name';
  final String emailLabel = "Email";
  final String phoneLabel = "Phone";
  final String addressLabel = "Address";

  final String username = 'Ditya Developer';

  String name = '';
  String email = '';
  String phone = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColour,
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushNamed('/homeadmin');
          },
        ),
      ),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  width: 320,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/logo.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              child: PrimaryText(
                                text: title,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('/profileadminupdate');
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icon_edit.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/icon_name.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SecondaryText(
                                  text: nameLabel,
                                  color: primaryColour,
                                  size: 16,
                                ),
                                SecondaryText(
                                  text: name,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/icon_phone.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SecondaryText(
                                  text: phoneLabel,
                                  color: primaryColour,
                                  size: 16,
                                ),
                                SecondaryText(
                                  text: '+62' + phone,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/icon_email.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SecondaryText(
                                  text: emailLabel,
                                  color: primaryColour,
                                  size: 16,
                                ),
                                SecondaryText(
                                  text: email,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/icon_address.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SecondaryText(
                                  text: addressLabel,
                                  color: primaryColour,
                                  size: 16,
                                ),
                                SecondaryText(
                                  text: address,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    final Firestore firestore = Firestore.instance;
    firestore.collection("users").document(uid).get().then((value) {
      print(value.data);
      print(value.data["name"].toString());
      print(value.data["phone"].toString());
      print(value.data["email"].toString());
      print(value.data["address"].toString());
      print(uid);
      setState(() {
        name = value.data["name"].toString();
        phone = value.data["phone"].toString();
        email = value.data["email"].toString();
        address = value.data["address"].toString();
      });
    });
  }
}
