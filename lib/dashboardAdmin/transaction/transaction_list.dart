import 'package:biznet/widget/package_list_widget.dart';
import 'package:biznet/widget/transaction_list_widget.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
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
              child: TransactionListWidget(),
            ),

      ),),
      
    );
  }
}