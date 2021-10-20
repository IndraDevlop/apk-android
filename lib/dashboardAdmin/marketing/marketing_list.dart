import 'package:biznet/widget/marketing_list_widget.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:flutter/material.dart';

class ListMarketing extends StatefulWidget {
  @override
  _ListMarketingState createState() => _ListMarketingState();
}

class _ListMarketingState extends State<ListMarketing> {
  final String title = 'Marketing List';

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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: MarketingListWidget(),
            ),
       ),
     ),
      
    );
  }
}