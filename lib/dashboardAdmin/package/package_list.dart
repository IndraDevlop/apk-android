import 'package:biznet/widget/package_list_widget.dart';
import 'package:flutter/material.dart';

class ListPackage extends StatefulWidget {
  @override
  _ListPackageState createState() => _ListPackageState();
}

class _ListPackageState extends State<ListPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // height: 640,
        // width: 360,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"), fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: PackageListWidget(),
            ),

      ),),
      
    );
  }
}