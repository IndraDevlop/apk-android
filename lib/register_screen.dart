import 'package:biznet/dashboardUser/landing_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget/primary_button.dart';
import 'widget/utils/const.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;
  final String register = 'Registration form';
  final String toLogin = 'Login';
  final String registerButton = 'Submit';

  final String userType = "customer";

  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final Firestore firestore = Firestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                      child: Row(
                      
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 78,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/logo.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        child: Text(
                          register,
                          style: TextStyle(fontSize: 24, color: primaryColour),
                        ),
                      ),
                      
                    ],
                  )),
                ),
                SizedBox(height: 10),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Name cannot be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Name', ),
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Phone Number cannot be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Phone',),
                        ),
                        TextFormField(
                          controller: addressController,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Address cannot be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Address',
                              ),
                        ),
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
                              return 'Enter Password';
                            } else if (value.length < 6) {
                              return 'Password must be atleast 6 characters!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Password', counterText: '123456'),
                        ),
                      ],
                    ),
                  ),
                ),
                PrimaryButton(
                    color: primaryColour,
                    text: registerButton,
                    onBtnPressed: () {
                       _create();
                    }),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/");
                    },
                    child: Container(
                      child: Text(toLogin),
                    )),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
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

  void _create() async {
    final FormState form = _form.currentState;
    if (!form.validate()) {
      showInSnackBar('Please insert the red line before submitting.');
    } else {
      try {
        form.save();
        await firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((result) {

              //Just only for admin
          // firestore
          //     .collection("partner")
          //     .document(nameController.text)
          //     .setData({
          //   'name': nameController.text,
          // });
          firestore.collection("users").document(result.user.uid).setData({
            'uid' : result.user.uid,
            'name': nameController.text,
            'phone': int.tryParse(phoneController.text) ?? 0,
            'address': addressController.text,
            'email': emailController.text,
            'password': passwordController.text,
            'type': userType,
          }).then((res) async {
            isLoading = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('uid', result.user.uid);
            prefs.setString('email', result.user.email);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LandingUserScreen()),
            );
          });
        });
      } catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        showInSnackBar(e.message);
      }
    }
  }

}
