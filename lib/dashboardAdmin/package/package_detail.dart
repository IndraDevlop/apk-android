import 'package:biznet/model/package.dart';
import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/regular_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PackageDetail extends StatefulWidget {
   PackageDetail({Key key, this.uid}) : super(key: key);
  final Package uid;

  @override
  _PackageDetailState createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {

  String _name = '';
  String _email = '';
  String _date = '';
  String _time = '';
  String _note = '';
  String _price = '';
  String _packagebandwidth = '';
  String _packagedevice = '';
  String _packagefeature = '';
  String _packageiptv = '';
  String _packagemodem = '';
  String _packagename = '';
  String _packagenetwork = '';
  String _packagetype = '';

  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
          child: Form(
            key: _form,
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
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status Package'),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            RegularText(
                                text: _packagenetwork,
                                color: Colors.black,
                                size: 14),
                            Text(' - '),
                            RegularText(
                                text: _packageiptv,
                                color: Colors.black,
                                size: 14),
                          ],
                        ),
                        Divider(),
                        Text('Data Pengguna'),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            RegularText(
                                text: _name, color: Colors.black, size: 14),
                            Text(' - '),
                            RegularText(
                                text: _email, color: Colors.black, size: 14),
                          ],
                        ),
                        Divider(),
                        Text('Waktu pembelian'),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            RegularText(
                                text: _date, color: Colors.black, size: 14),
                            Text(' - '),
                            RegularText(
                                text: _time, color: Colors.black, size: 14),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Center(
                        child: Container(
                          width: 250,
                          child: Column(
                            children: [
                              Divider(),
                              PrimaryText(text: _packagename),
                              SecondaryText(
                                  text: _packagetype,
                                  color: Colors.black,
                                  size: 16),
                              SizedBox(height: 15),
                              Divider(),
                              SizedBox(height: 15),
                              Container(
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RegularText(
                                        text: _packagefeature,
                                        color: Colors.black,
                                        size: 14),
                                    SizedBox(height: 15),
                                    RegularText(
                                        text: _packagemodem,
                                        color: Colors.black,
                                        size: 14),
                                    SizedBox(height: 15),
                                    RegularText(
                                        text: _packagebandwidth,
                                        color: Colors.black,
                                        size: 14),
                                    SizedBox(height: 15),
                                    RegularText(
                                        text: _packagedevice,
                                        color: Colors.black,
                                        size: 14),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              Divider(),
                              RegularText(
                                  text: _note, color: Colors.black, size: 14),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
                SizedBox(height: 70),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SecondaryText(
                          text: 'Rp. $_price.00,-',
                          color: Colors.black,
                          size: 14),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        )),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final Firestore firestore = Firestore.instance;
    firestore.collection("package").document(widget.uid.id).get().then((value) {
      print(value.data);
      print(value.data["package_name"].toString());
      print(value.data["package_device"].toString());
      print(value.data["package_feature"].toString());
      print(value.data["package_iptv"].toString());
      print(value.data["package_modem"].toString());
      print(value.data["package_network"].toString());
      print(value.data["package_type"].toString());
      print(value.data["package_bandwidth"].toString());
      print(value.data["price"].toString());
      print(value.data["note"].toString());
      print(value.data["name"].toString());
      print(value.data["email"].toString());
      print(value.data["date"].toString());
      print(value.data["time"].toString());
      setState(() {
        _packagename = value.data["package_name"].toString();
        _packagedevice = value.data["package_device"].toString();
        _packagefeature = value.data["package_feature"].toString();
        _packageiptv = value.data["package_iptv"].toString();
        _packagemodem = value.data["package_modem"].toString();
        _packagenetwork = value.data["package_network"].toString();
        _packagetype = value.data["package_type"].toString();
        _packagebandwidth = value.data["package_bandwidth"].toString();
        _price = value.data["price"].toString();
        _note = value.data["note"].toString();
        _name = value.data["name"].toString();
        _email = value.data["email"].toString();
        _date = value.data["date"].toString();
        _time = value.data["time"].toString();
      });
    });
  }
}