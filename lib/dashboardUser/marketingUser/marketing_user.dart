import 'package:biznet/widget/user_marketing_list_widget.dart';
import 'package:flutter/material.dart';

class MarketingUser extends StatefulWidget {
  @override
  _MarketingUserState createState() => _MarketingUserState();
}

class _MarketingUserState extends State<MarketingUser> {
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                    constraints:
                        BoxConstraints(minWidth: 400.0, minHeight: 25.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: UserMarketingListWidget(),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
