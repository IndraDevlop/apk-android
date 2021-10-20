import 'package:biznet/dashboardUser/home_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboardAdmin/home_admin.dart';
import 'dashboardUser/landing_user.dart';
import 'widget/primary_button.dart';
import 'widget/utils/const.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final String login = "Login";
  final String toRegister = "you dont have account ? register here";

  String typeUser;
  String email;

  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  height: 150,
                  width: 118,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 265,
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            counterText: 'password must be 6 digits or more'),
                      ),
                      SizedBox(height: 10),
            PrimaryButton(
                color: primaryColour,
                text: login,
                onBtnPressed: () {
                  _login();
                }),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, "/register");
              },
              child: Container(
                child: Text(toRegister),
              ),
            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        elevation: 20.0,
        backgroundColor: primaryColour,
        behavior: SnackBarBehavior.floating,
        content: new Text(
          value != null ? value : '',
          textAlign: TextAlign.center,
        )));
  }

  Future<void> _login() async {
    final FormState form = _form.currentState;
    if (!form.validate()) {
      showInSnackBar('Please insert the red line before submitting.');
    } else {
      try {
        form.save();
        final user = (await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        ))
            .user;
        showInSnackBar('${user.email} signed in');
        print(user.uid);
        try {
          DocumentSnapshot documentSnapshot;
          final FirebaseUser user = await _auth.currentUser();
          firestore.collection("users").document(user.uid).get().then((value) {
            setState(() {
              typeUser = value.data["type"].toString();
              email = value.data["email"].toString();
              print(typeUser+ ' ' + email);
            });
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('uid', user.uid);
          prefs.setString('email', user.email);
          documentSnapshot =
              await firestore.collection('users').document(user.uid).get();

          print('contoh id : ${documentSnapshot.data}');
          print('contoh uid : ${user.uid}');
          print('contoh email : ${user.email}');
          print(typeUser);
          switch (typeUser) {
            case "customer":
            new Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LandingUserScreen()),
              );
            });
              break;
            case "admin":
            new Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeAdmin()),
              );
            });
              break;
            // case "superadmin":
            // new Future.delayed(const Duration(seconds: 3), () {
            //   Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             HomeSuperAdmin(uid: documentSnapshot.documentID)),
            //   );
            // });
            //   break;
          }
        } catch (e) {
          print(e);
        }
      } catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        showInSnackBar(e.message);
      }
    }
  }



}
