import 'package:biznet/model/user.dart';
import 'package:biznet/services/firestore_services.dart';
import 'package:biznet/widget/primary_button.dart';
import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileAdminUpdate extends StatefulWidget {
  @override
  _ProfileAdminUpdateState createState() => _ProfileAdminUpdateState();
}

class _ProfileAdminUpdateState extends State<ProfileAdminUpdate> {
  final String title = 'Update Your Profile';

  final String nameLabel = 'Admin Name';
  final String emailLabel = "Email";
  final String phoneLabel = "Phone";
  final String addressLabel = "Address";

  final String username = 'Ditya Developer';
  final String buttonSubmit = 'Submit';

  String _uid = '';
  String name = '';
  String email = '';
  String phone = '';
  String address = '';

  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController rekening1Controller = new TextEditingController();
  final TextEditingController rekening2Controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColour,
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/homeadmin", (route) => false);
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
            child: Form(
              key: _form,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Container(
                    width: 320,
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
                                  Container(
                                    width: 230,
                                    constraints: BoxConstraints(
                                        minWidth: 230.0, minHeight: 25.0),
                                    child: TextFormField(
                                      readOnly: true,
                                      //controller: nameController,
                                      keyboardType: TextInputType.name,
                                     
                                      decoration: InputDecoration(
                                          labelText: 'Admin Name',
                                          hintText: name,
                                          counterText: 'ditya developer'),
                                    ),
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
                                          AssetImage("assets/icon_phone.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 230,
                                    constraints: BoxConstraints(
                                        minWidth: 230.0, minHeight: 25.0),
                                    child: TextFormField(
                                      readOnly: true,
                                      //controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      
                                      decoration: InputDecoration(
                                          labelText: 'Phone',
                                          hintText: phone,
                                          counterText: '081292921433'),
                                    ),
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
                                          AssetImage("assets/icon_email.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 230,
                                    constraints: BoxConstraints(
                                        minWidth: 230.0, minHeight: 25.0),
                                    child: TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          labelText: 'Email',
                                          hintText: email,
                                          counterText: 'dityadev@project.com'),
                                    ),
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
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 230,
                                      constraints: BoxConstraints(
                                          minWidth: 230.0, minHeight: 25.0),
                                      child: TextFormField(
                                        readOnly: true,
                                        //controller: addressController,
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        
                                        decoration: InputDecoration(
                                            labelText: 'Address',
                                            hintText: address,
                                            counterText: 'Jalan merindu'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Container(
                        //         width: 230,
                        //         constraints: BoxConstraints(
                        //             minWidth: 230.0, minHeight: 25.0),
                        //         child: TextFormField(
                        //           //readOnly: true,
                        //           controller: rekening1Controller,
                        //           keyboardType: TextInputType.streetAddress,
                        //           validator: (value) {
                        //             if (value.isEmpty) {
                        //               return "rekening 1 cannot be empty";
                        //             }
                        //             return null;
                        //           },
                        //           decoration: InputDecoration(
                        //               labelText: 'Rekening BCA',
                        //               // hintText: address,
                        //               counterText: 'Rekening BCA'),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Container(
                        //         width: 230,
                        //         constraints: BoxConstraints(
                        //             minWidth: 230.0, minHeight: 25.0),
                        //         child: TextFormField(
                        //           // readOnly: true,
                        //           controller: rekening2Controller,
                        //           keyboardType: TextInputType.streetAddress,
                        //           validator: (value) {
                        //             if (value.isEmpty) {
                        //               return "Rekening mandiri cannot be empty";
                        //             }
                        //             return null;
                        //           },
                        //           decoration: InputDecoration(
                        //               labelText: 'Rekening Mandiri',
                        //               //hintText: address,
                        //               counterText: 'Rekening Mandiri'),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // PrimaryButton(
                  //     color: primaryColour,
                  //     text: buttonSubmit,
                  //     onBtnPressed: () {
                  //       _updateProfile();
                  //     })
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
    final Firestore firestore = Firestore.instance;
    firestore.collection("users").document(uid).get().then((value) {
      print(value.data);
      print(uid);
      print(value.data["name"].toString());
      print(value.data["phone"].toString());
      print(value.data["email"].toString());
      print(value.data["address"].toString());
      setState(() {
        name = value.data["name"].toString();
        phone = value.data["phone"].toString();
        email = value.data["email"].toString();
        address = value.data["address"].toString();
        _uid = uid;
      });
    });
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

  void _updateProfile() async {
    final FormState form = _form.currentState;
    if (!form.validate()) {
      showInSnackBar('Please insert the red line before submitting.');
    } else {
      try {
        form.save();
        User user = User(
          name: name,
          phone: int.tryParse(phone) ?? 0,
          address: address,
          email: email,
          rekeningBCA: rekening1Controller.text,
          rekeningMandiri: rekening2Controller.text,
        );
        //await FirestoreService().updateUser(user);
        Navigator.pushNamedAndRemoveUntil(
            context, "/profileadmin", (route) => false);
      } catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        showInSnackBar(e.message);
      }
    }
  }
}
