import 'dart:io';

import 'package:biznet/model/package.dart';
import 'package:biznet/model/tagihan.dart';
import 'package:biznet/model/update_bukti.dart';
import 'package:biznet/services/firestore_services.dart';
import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/regular_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class TagihanUserDetail extends StatefulWidget {
  TagihanUserDetail({Key key, this.uid}) : super(key: key);
  final Package uid;

  @override
  _TagihanUserDetailState createState() => _TagihanUserDetailState();
}

class _TagihanUserDetailState extends State<TagihanUserDetail> {
  final Color _primaryColour = primaryColour;
  final Color orange = Color(0xfff335da1);
  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File _imageFile;

  final picker = ImagePicker();
  String imgLoc;

  String uidTransaksi;
  String uidTagihan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Center(
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
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.uid.statusDevice,
                                    style: TextStyle(color: Colors.white)),
                              )),
                          RegularText(
                              text: widget.uid.packageiptv,
                              color: Colors.black,
                              size: 14),
                          Divider(),
                          Text('Waktu pembelian'),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              RegularText(
                                  text: widget.uid.date,
                                  color: Colors.black,
                                  size: 14),
                              Text(' - '),
                              RegularText(
                                  text: widget.uid.time,
                                  color: Colors.black,
                                  size: 14),
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
                            // width: 250,
                            child: Column(
                              children: [
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: widget.uid.statusDevice == 'Non-Active'
                                      ? Container(
                                          color: Colors.white30,
                                          width: 300,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "Transaksi kamu sudah habis, silahkan upload bukti transaksi yang terbaru",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: primaryColour,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 250,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: primaryColour),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            child: CachedNetworkImage(
                                              imageUrl: widget.uid.img,
                                              placeholder: (context, url) =>
                                                  Container(
                                                height: 90,
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Sedang mengambil gambar',
                                                        style: TextStyle(
                                                            color:
                                                                primaryColour),
                                                      ),
                                                      Container(
                                                          height: 25,
                                                          child:
                                                              CircularProgressIndicator()),
                                                      Text('Mohon menunggu',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColour)),
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
                                PrimaryText(text: widget.uid.packagename),
                                SecondaryText(
                                    text: widget.uid.packagetype,
                                    color: Colors.black,
                                    size: 16),
                                SizedBox(height: 15),
                                Divider(),
                                SizedBox(height: 15),
                                Container(
                                  width: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RegularText(
                                          text: widget.uid.packagebandwidth,
                                          color: Colors.black,
                                          size: 14),
                                      SizedBox(height: 15),
                                      RegularText(
                                          text: widget.uid.packagefeature,
                                          color: Colors.black,
                                          size: 14),
                                      SizedBox(height: 15),
                                      RegularText(
                                          text: widget.uid.packagemodem,
                                          color: Colors.black,
                                          size: 14),
                                      SizedBox(height: 15),
                                      RegularText(
                                          text: widget.uid.packagedevice,
                                          color: Colors.black,
                                          size: 14),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SecondaryText(
                            text: 'Rp. ${widget.uid.price}.00,-',
                            color: Colors.black,
                            size: 14),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    child: widget.uid.statusDevice == 'Non-Active'
                        ? Container(
                            // height: 250,
                            width: 315,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            // margin: const EdgeInsets.only(
                            //     left: 30.0, right: 30.0, top: 10.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: _imageFile != null
                                    ? Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 250,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  child:
                                                      Image.file(_imageFile))),
                                          SizedBox(height: 40),
                                          Container(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 210,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white54,
                                                      border: Border.all(
                                                          color: primaryColour),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Terima kasih Mr.${widget.uid.name}',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  primaryColour,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          Text(
                                                            'silahkan submit untuk diproses kembali',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  primaryColour,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  submit(context),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                              Container(
                                                width: 90,
                                                child: ClipRRect(
                                                  // borderRadius: BorderRadius.circular(50.0),
                                                  child: Image.asset(
                                                      'assets/ava_package.png'),
                                                ),
                                              ),
                                            ],
                                          )),
                                        ],
                                      ))
                                    : Row(
                                        children: [
                                          Container(
                                            width: 90,
                                            child: ClipRRect(
                                              // borderRadius: BorderRadius.circular(50.0),
                                              child: Image.asset(
                                                  'assets/ava_package_back.png'),
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                pickImage();
                                              },
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Foto bukti transaksi kamu disini ya',
                                                    style: TextStyle(
                                                      color: primaryColour,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Container(
                                                    height: 150,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      child: Image.asset(
                                                          'assets/no_image.png'),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      )),
                          )
                        : Container(),
                  )
                ],
              ),
            ),
          )),
        )),
      ),
    );
  }

  Widget submit(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_primaryColour, orange],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => _updateTagihan(context),
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        elevation: 20.0,
        backgroundColor: primaryColour,
        behavior: SnackBarBehavior.floating,
        content: new Text(
          value != null ? value : '',
          textAlign: TextAlign.center,
        )));
  }

  Future _updateTagihan(BuildContext context) async {
    final FormState form = _form.currentState;
    if (!form.validate()) {
      showInSnackBar('Please insert the red line before submitting.');
    } else {
      try {
        form.save();
        String fileName = basename(_imageFile.path);
        StorageReference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('tagihan/$fileName');
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        print(downloadUrl);

        UpdateBukti bukti = UpdateBukti(
          img: downloadUrl,
        );
        uidTransaksi = widget.uid.uidTransaksi;
        uidTagihan = widget.uid.uidTagihan;
        await FirestoreService().updateBuktiTransaksi(bukti, uidTransaksi);
        await FirestoreService().updateBuktiTagihan(bukti, uidTagihan);

        showInSnackBar(
            'Terima kasih ${widget.uid.name} tagihan kamu akan diproses');
        new Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
              context, "/landing", (route) => false);
        });
      } catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        showInSnackBar(e.message);
      }
    }
  }

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile == null) {
        return 'No seleted image';
      } else {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // _loadData();
  }

  // void _loadData() async {
  //   final Firestore firestore = Firestore.instance;
  //   firestore.collection("transaksi").document(widget.uid.id).get().then((value) {
  //     print(value.data);
  //     print(value.data["package_name"].toString());
  //     print(value.data["package_device"].toString());
  //     print(value.data["package_feature"].toString());
  //     print(value.data["package_iptv"].toString());
  //     print(value.data["package_modem"].toString());
  //     print(value.data["package_network"].toString());
  //     print(value.data["package_type"].toString());
  //     print(value.data["package_bandwidth"].toString());
  //     print(value.data["price"].toString());
  //     print(value.data["note"].toString());
  //     print(value.data["name"].toString());
  //     print(value.data["email"].toString());
  //     print(value.data["date"].toString());
  //     print(value.data["time"].toString());
  //     setState(() {
  //       _packagename = value.data["package_name"].toString();
  //       _packagedevice = value.data["package_device"].toString();
  //       _packagefeature = value.data["package_feature"].toString();
  //       _packageiptv = value.data["package_iptv"].toString();
  //       _packagemodem = value.data["package_modem"].toString();
  //       _packagenetwork = value.data["package_network"].toString();
  //       _packagetype = value.data["package_type"].toString();
  //       _packagebandwidth = value.data["package_bandwidth"].toString();
  //       _price = value.data["price"].toString();
  //       _note = value.data["note"].toString();
  //       _name = value.data["name"].toString();
  //       _email = value.data["email"].toString();
  //       _date = value.data["date"].toString();
  //       _time = value.data["time"].toString();
  //     });
  //   });
  // }
}
