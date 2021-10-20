import 'package:biznet/dashboardAdmin/uploadImage/upload2_example.dart';
import 'package:biznet/register_screen.dart';
import 'package:flutter/material.dart';

import 'dashboardAdmin/home_admin.dart';
import 'dashboardAdmin/marketing/marketing_create.dart';
import 'dashboardAdmin/package/package_create.dart';
import 'dashboardAdmin/package_marketing.dart';
import 'dashboardAdmin/profile/profile_admin.dart';
import 'dashboardAdmin/profile/profile_admin_update.dart';
import 'dashboardAdmin/transaction/transaction_list.dart';
import 'dashboardAdmin/uploadImage/upload_example.dart';
import 'dashboardUser/beliUser/beli_package.dart';
import 'dashboardUser/home_user.dart';
import 'dashboardUser/lainnyaUser/about_user.dart';
import 'dashboardUser/lainnyaUser/call_center.dart';
import 'dashboardUser/landing_user.dart';
import 'dashboardUser/profileUser/profile_user.dart';
import 'dashboardUser/profileUser/profile_user_update.dart';
import 'login_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/" : (context) => Login(),
        "/register" : (context) => Register(),
        "/homeadmin" : (context) => HomeAdmin(),
        "/profileadmin" : (context) => ProfileAdmin(),
        "/profileuser" : (context) => ProfileUser(),
        "/profileadminupdate" : (context) => ProfileAdminUpdate(),
        "/profileuserupdate" : (context) => ProfileUserUpdate(),
        "/packagecreate" : (context) => PackageCreate(),
        "/marketingcreate" : (context) => MarketingCreate(),
        "/packagemarketing" : (context) => PackageMarketingScreen(),
        "/about" : (context) => AboutUser(),
        "/callcenter" : (context) => CallCenter(),
        "/landing" : (context) => LandingUserScreen(),
        "/transaction" : (context) => TransactionList(),
        "/uploadimage" : (context) => UploadExample(),
        "/uploadimage2" : (context) => Upload2(),
        "/belipackage" : (context) => BeliPackage(),
      }, 
    );
  }
}