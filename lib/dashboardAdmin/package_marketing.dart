import 'package:biznet/widget/utils/const.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'marketing/marketing_list.dart';
import 'package/package_list.dart';
import 'profile/profile_admin.dart';
import 'profile/profile_admin_update.dart';

class PackageMarketingScreen extends StatefulWidget {
  @override
  _PackageMarketingScreenState createState() => _PackageMarketingScreenState();
}

class _PackageMarketingScreenState extends State<PackageMarketingScreen> {
  final String title = 'Package and Marketing';

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            ListPackage(),
            ListMarketing(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: primaryColour,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('List Package'),
              icon: Icon(Icons.list_alt),
              activeColor: Colors.white,
              inactiveColor: Colors.white30),
          BottomNavyBarItem(
              title: Text('List Content'),
              icon: Icon(Icons.surround_sound_outlined),
              activeColor: Colors.white,
              inactiveColor: Colors.white30),
        ],
      ),
    );
  }
}
