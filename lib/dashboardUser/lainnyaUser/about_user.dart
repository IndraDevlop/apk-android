import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AboutUser extends StatefulWidget {
  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {

  final String title = 'About Developers';

  final String nameLabel = 'Developer Name';
  final String emailLabel = "NPM";
  final String phoneLabel = "Phone";
  final String addressLabel = "Universitas";
  final String prodiLabel = "Program Studi";
  final String birthLabel = "Tanggal Lahir";

  String name = '';
  String npm = '';
  String phone = '';
  String birth = '';
  String prodi = '';
  String universitas = '';
  String version = '';

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
                                  text: npm,
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
                                  text: universitas,
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
                                        AssetImage("assets/icon_universitas.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SecondaryText(
                                  text: prodiLabel,
                                  color: primaryColour,
                                  size: 16,
                                ),
                                SecondaryText(
                                  text: prodi,
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
                                        AssetImage("assets/icon_birth.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SecondaryText(
                                  text: birthLabel,
                                  color: primaryColour,
                                  size: 16,
                                ),
                                SecondaryText(
                                  text: birth,
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
                
                SizedBox(height: 50),
                Container(child: PrimaryText(text: 'Version apps : $version'))
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
    final Firestore firestore = Firestore.instance;
    firestore.collection("about").document('profile').get().then((value) {
      print(value.data); 
      print(value.data["name"].toString());
      print(value.data["phone"].toString());
      print(value.data["npm"].toString());
      print(value.data["prodi"].toString());
      print(value.data["universitas"].toString());
      print(value.data["version"].toString());
      print(value.data["birth"].toString());
      setState(() {
        name = value.data["name"].toString();
        phone = value.data["phone"].toString();
        npm = value.data["npm"].toString();
        prodi = value.data["prodi"].toString();
        universitas = value.data["universitas"].toString();
        version = value.data["version"].toString();
        birth = value.data["birth"].toString();
      });
    });
  }

}
