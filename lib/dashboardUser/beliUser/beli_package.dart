import 'dart:io';

import 'package:biznet/model/package.dart';
import 'package:biznet/model/user_data.dart';
import 'package:biznet/services/firestore_services.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeliPackage extends StatefulWidget {
  BeliPackage({Key key, this.uid}) : super(key: key);
  final Package uid;

  @override
  _BeliPackageState createState() => _BeliPackageState();
}

class _BeliPackageState extends State<BeliPackage> {
  final Color _primaryColour = primaryColour;
  final Color orange = Color(0xfff335da1);

  final String title = 'pembayaran';

  String _packagename = '';
  String _packagedevice = '';
  String _packagebandwidth = '';
  String _packageiptv = '';
  String _packagefeature = '';
  String _packagemodem = '';
  String _packagenetwork = '';
  String _packagetype = '';
  String _price = '';
  String _note = '';
  String _statusPayment = 'Belum bayar';
  String _statusDevice = 'Belum active';
  String _dataPackage = '';

  String docRef;

  String _uid = '';
  String _name = '';
  String _nameRek = '';
  String _email = '';
  String _phone = '';
  String _type = '';
  String _address = '';
  String _rekBCA = '';
  String _rekMandiri = '';
  String _rekBNI = '';
  String _harga = '';
  String imgLoc;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  String date;
  String time;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  File _imageFile;

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColour,
        title: Text(title),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // height: 640,
            // width: 360,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 230,
                            color: Colors.white38,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  'Halo',
                                  style: TextStyle(
                                      color: primaryColour,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '$_name',
                                  style: TextStyle(
                                      color: primaryColour,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'kita bertemu lagi',
                                  style: TextStyle(
                                      color: primaryColour,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'untuk pembayaran kamu',
                                  style: TextStyle(
                                      color: primaryColour,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'diproses dibawah ini ya',
                                  style: TextStyle(
                                      color: primaryColour,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset('assets/ava_package.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: 350,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white30,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Container(
                                height: 30,
                                child: Text(
                                  'Data Pelanggan',
                                  style: TextStyle(
                                      color: primaryColour,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                            Container(
                              width: 120,
                              child: Column(
                                children: [
                                  Divider(
                                    color: primaryColour,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Nama Pelanggan :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            _name ?? null,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Email Pelanggan :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            _email ?? null,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            'No Hp. Pelanggan :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            _phone ?? null,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Alamat :',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(width: 10),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            _address ?? null,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                height: 30,
                                child: Text(
                                  'Data Paket',
                                  style: TextStyle(
                                      color: primaryColour,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                            Container(
                              width: 120,
                              child: Column(
                                children: [
                                  Divider(
                                    color: primaryColour,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Nama Paket :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            widget.uid.packagename ?? null,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Type :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            widget.uid.packagetype ?? null,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Status :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            widget.uid.packagenetwork ?? null,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Harga :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            widget.uid.price.toString() ?? null,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Row(
                        children: [
                          Container(
                            width: 90,
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset('assets/ava_package_back.png'),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColour),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pastikan data kamu benar',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: primaryColour),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          'dan lakukan transaksi ke salah satu rekening dibawah ini',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: primaryColour),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white30,
                                  border: Border.all(color: primaryColour),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        child: ClipRRect(
                                          // borderRadius: BorderRadius.circular(50.0),
                                          child: Image.asset('assets/bca.png'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Tranksasi melalui rekening BCA',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: primaryColour),
                                      ),
                                      Container(
                                        width: 190,
                                        child: Divider(
                                          color: primaryColour,
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          '1. pilih menu “Transfer” dan “Ke Rek BCA”.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          '2. Kemudian, masukkan nomor rekening BCA : $_rekBCA a/n $_nameRek',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          '3. Setelah itu, lanjutkan dengan memasukkan nominal yang akan ditransfer sebesar Rp.${widget.uid.price}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white30,
                                  border: Border.all(color: primaryColour),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        child: ClipRRect(
                                          // borderRadius: BorderRadius.circular(50.0),
                                          child:
                                              Image.asset('assets/mandiri.png'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Tranksasi melalui rekening Mandiri',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: primaryColour),
                                      ),
                                      Container(
                                        width: 190,
                                        child: Divider(
                                          color: primaryColour,
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          '1. pilih menu “Transfer” dan “Ke Rek Mandiri”.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          '2. Kemudian, masukkan nomor rekening Mandiri : $_rekBCA a/n $_nameRek',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          '3. Setelah itu, lanjutkan dengan memasukkan nominal yang akan ditransfer sebesar Rp.${widget.uid.price}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(
                            color: primaryColour,
                            thickness: 2,
                          ),
                          Text(
                            'Upload bukti transaksi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColour,
                              fontSize: 16,
                            ),
                          ),
                          Divider(
                            color: primaryColour,
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
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
                                  children: [
                                    Container(
                                        height: 250,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            child: Image.file(_imageFile))),
                                    SizedBox(height: 40),
                                    Container(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: 210,
                                              decoration: BoxDecoration(
                                                color: Colors.white54,
                                                border: Border.all(
                                                    color: primaryColour),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Terima kasih telah melakukan sampai tahap ini Mr.$_name',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: primaryColour,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      'senang bisa membantu.',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: primaryColour,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: 210,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'tanggal : ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${_dateController.text}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColour,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              width: 210,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'waktu : ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${_timeController.text}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColour,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white54,
                                                border: Border.all(
                                                    color: primaryColour),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              width: 210,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'tanggal dan waktu telah ku catat sebagai bukti waktu pembelian paket $_packagename',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryColour,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white54,
                                                border: Border.all(
                                                    color: primaryColour),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              width: 210,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'untuk selanjutnya kamu dapat melakukan submit data agar diproses oleh admin',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryColour,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                                    BorderRadius.circular(30.0),
                                                child: Image.asset(
                                                    'assets/no_image.png'),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                )),
                    ),
                    SizedBox(height: 20),
                    submit(context),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //_loadData();
    _loadUserRek();
    _loadUser();
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    final Firestore firestore = Firestore.instance;
    firestore.collection("users").document(uid).get().then((value) {
      print(value.data);
      print(value.data["name"].toString());
      print(value.data["phone"].toString());
      print(value.data["address"].toString());
      print(value.data["data_package"].toString());
      print(value.data["type"].toString());
      print(value.data["uid"].toString());
      setState(() {
        _name = value.data["name"].toString();
        _email = value.data["email"].toString();
        _phone = value.data["phone"].toString();
        _address = value.data["address"].toString();
        _type = value.data["type"].toString();
        _uid = value.data["uid"].toString();
      });
    });
  }

  void _loadUserRek() async {
    final Firestore firestore = Firestore.instance;
    firestore.collection("about").document('profile').get().then((value) {
      print(value.data);
      print(value.data["name"].toString());
      print(value.data["rekeningBCA"].toString());
      print(value.data["rekeningBNI"].toString());
      print(value.data["rekeningMandiri"].toString());
      setState(() {
        _nameRek = value.data["name"].toString();
        _rekBCA = value.data["rekeningBCA"].toString();
        _rekBNI = value.data["rekeningBNI"].toString();
        _rekMandiri = value.data["rekeningMandiri"].toString();
      });
    });
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
      print(value.data["image"].toString());
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
        // _image = value.data["image"].toString();
      });
    });
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
              onPressed: () => _createTagihan(context),
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

  Future _createTagihan(BuildContext context) async {
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

        final collRef = Firestore.instance.collection('transaksi');
        DocumentReference docReference = collRef.document();

        docReference.setData({
          'name': _name,
          'email': _email,
          'uid': _uid,
          'uid_transaksi': docReference.documentID,
          'status_payment': _statusPayment,
          'status_device': _statusDevice,
          'package_name': widget.uid.packagename,
          'price': int.tryParse(widget.uid.price.toString()),
          'package_type': widget.uid.packagetype,
          'package_bandwidth': widget.uid.packagebandwidth,
          'package_device': widget.uid.packagedevice,
          'package_iptv': widget.uid.packageiptv,
          'package_modem': widget.uid.packagemodem,
          'package_feature': widget.uid.packagefeature,
          'package_network': widget.uid.packagenetwork,
          'date': _dateController.text,
          'time': _timeController.text,
          'image': downloadUrl,
        }).then((doc) {
          print('get ${docReference.documentID}');
        }).catchError((error) {
          print(error);
        });

        UserData user = UserData(
          uid: _uid,
          name: _name,
          email: _email,
          phone: int.tryParse(_phone),
          address: _address,
          type: _type,
          dataPackage: 'non-active',
        );
        await FirestoreService().updateUserDataPackage(user);

        showInSnackBar('Terima kasih $_name tagihan kamu akan diproses');
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }
}
