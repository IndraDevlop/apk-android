import 'package:biznet/model/marketing.dart';
import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/regular_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MarketingUserDetail extends StatefulWidget {
  MarketingUserDetail({Key key, this.uid}) : super(key: key);
  final MarketingModel uid;

  @override
  _MarketingUserDetailState createState() => _MarketingUserDetailState();
}

class _MarketingUserDetailState extends State<MarketingUserDetail> {
  String author = '';
  String title = '';
  String subtitle = '';
  String body = '';
  String _date = '';
  String _time = '';

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
        //height: 640,
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
                height: 160,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/logo.png"), fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 10),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RegularText(
                          text: widget.uid.date, color: Colors.black, size: 14),
                      Text(' - '),
                      RegularText(
                          text: widget.uid.time, color: Colors.black, size: 14),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                     // height: 180,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColour),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.uid.img,
                          height: 160,
                          width: 250,
                          placeholder: (context, url) => Container(
                            height: 90,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Sedang mengambil gambar',
                                    style: TextStyle(color: primaryColour),
                                  ),
                                  Container(
                                      height: 25,
                                      child: CircularProgressIndicator()),
                                  Text('Mohon menunggu',
                                      style: TextStyle(color: primaryColour)),
                                ],
                              ),
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  PrimaryText(text: widget.uid.title),
                  SizedBox(height: 10),
                  SecondaryText(
                      text: widget.uid.subtitle, color: Colors.black, size: 16),
                  SizedBox(height: 10),
                  //RegularText(text: body, color: Colors.black, size: 14)
                  Text(
                    widget.uid.body,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              )),
              SizedBox(height: 70),
              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Text(_authorLabel),
              //       SecondaryText(text: author, color: Colors.black, size: 14),
              //     ],
              //   ),
              // )
            ],
          ),
        )),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    // _loadUser();
  }

  void _loadUser() async {
    final Firestore firestore = Firestore.instance;
    firestore
        .collection("marketing")
        .document(widget.uid.id)
        .get()
        .then((value) {
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
