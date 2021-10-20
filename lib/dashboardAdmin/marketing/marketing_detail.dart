import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/regular_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MarketingDetail extends StatefulWidget {
  MarketingDetail({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  _MarketingDetailState createState() => _MarketingDetailState();
}

class _MarketingDetailState extends State<MarketingDetail> {
  String author = '';
  String title = '';
  String subtitle = '';
  String body = '';
  String date = '';
  String time = '';

  String _date = '5/20/2021';
  String _time = '20.00 wib';
  String _title = 'Ini judul';
  String _username = 'Ditya Developer';
  String _authorLabel = 'Author for this content is ';
  String _subtitle = 'Ini sub judul';
  String _body =
      'Ini sub judul yang berisikan teks panjang banget ya\napalagi ada ginian \nmakin panjang';

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
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Text(widget.uid),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RegularText(text: _date, color: Colors.black, size: 14),
                      Text(' - '),
                      RegularText(text: _time, color: Colors.black, size: 14),
                    ],
                  ),
                  SizedBox(height: 10),
                  PrimaryText(text: title),
                  SizedBox(height: 10),
                  SecondaryText(text: subtitle, color: Colors.black, size: 16),
                  SizedBox(height: 10),
                  RegularText(text: body, color: Colors.black, size: 14)
                ],
              )),
              SizedBox(height: 70),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_authorLabel),
                    SecondaryText(
                        text: author, color: Colors.black, size: 14),
                  ],
                ),
              )
            ],
          ),
        )),
      )),
    );
  }

   @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    final Firestore firestore = Firestore.instance;
    firestore.collection("marketing").document(widget.uid).get().then((value) {
      print(value.data);
      print(value.data["author"].toString());
      print(value.data["title"].toString());
      print(value.data["subtitle"].toString());
      print(value.data["body"].toString());
      print(value.data["date"].toString());
      print(value.data["time"].toString());
      setState(() {
        author = value.data["author"].toString();
        title = value.data["title"].toString();
        subtitle = value.data["subtitle"].toString();
        body = value.data["body"].toString();
        _date = value.data["date"].toString();
        _time = value.data["time"].toString();
      });
    });
  }


}
