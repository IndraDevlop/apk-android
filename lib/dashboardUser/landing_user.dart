import 'package:biznet/widget/user_tagihan_list_widget.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'beliUser/beli_user.dart';
import 'home_user.dart';
import 'lainnyaUser/lainnya.dart';
import 'tagihan_user.dart/tagihan_user.dart';

class LandingUserScreen extends StatefulWidget {
  @override
  _LandingUserScreenState createState() => _LandingUserScreenState();
}

class _LandingUserScreenState extends State<LandingUserScreen> {
  final String title = 'Package and Marketing';

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              HomeUser(),
              UserTagihan(),
              BeliUser(),
              Lainnya(),
            ],
          ),
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
              title: Text('Beranda'),
              icon: Icon(Icons.home_outlined),
              activeColor: Colors.white,
              inactiveColor: Colors.white30),
          BottomNavyBarItem(
              title: Text('Tagihan'),
              icon: Icon(Icons.track_changes_sharp),
              activeColor: Colors.white,
              inactiveColor: Colors.white30),
          BottomNavyBarItem(
              title: Text('Beli'),
              icon: Icon(Icons.payment_outlined),
              activeColor: Colors.white,
              inactiveColor: Colors.white30),
          BottomNavyBarItem(
              title: Text('Lainnya'),
              icon: Icon(Icons.settings_applications_outlined),
              activeColor: Colors.white,
              inactiveColor: Colors.white30),
        ],
      ),
    );
  }
}
