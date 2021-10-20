import 'package:biznet/dashboardUser/beliUser/beli_package.dart';
import 'package:biznet/model/package.dart';
import 'package:biznet/services/firestore_services.dart';
import 'package:biznet/widget/primary_button.dart';
import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/regular_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageUserDetail extends StatefulWidget {
  PackageUserDetail({Key key, this.uid}) : super(key: key);
  final Package uid;

  @override
  _PackageUserDetailState createState() => _PackageUserDetailState();
}

class _PackageUserDetailState extends State<PackageUserDetail> {
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
  String _image = '';

  String _name;
  String _email;
  String _phone;
  String _dataPackage;

  String _title = 'Ini judul';
  String _username = 'Ditya Developer';
  String _authorLabel = 'Author for this content is ';
  String _subtitle = 'Ini sub judul';
  String _body =
      'Ini sub judul yang berisikan teks panjang banget ya\napalagi ada ginian \nmakin panjang';

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isActiveBuy = false;
  double size;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 180,
                      width: 260,
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
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Jaringan',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                          SizedBox(width: 5),
                          RegularText(
                              text: widget.uid.packagenetwork,
                              color: Colors.black,
                              size: 14),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'IPTV',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(width: 5),
                          RegularText(
                              text: widget.uid.packageiptv,
                              color: Colors.black,
                              size: 14),
                        ],
                      ),
                      SizedBox(height: 10),
                      Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Container(
                          width: 350,
                          child: Column(
                            children: [
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
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        SecondaryText(
                                            text: 'Keuntungan kamu :',
                                            color: Colors.black,
                                            size: 16),
                                        SizedBox(height: 10),
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
                                            text: widget.uid.packagebandwidth,
                                            color: Colors.black,
                                            size: 14),
                                        SizedBox(height: 15),
                                        RegularText(
                                            text: widget.uid.packagedevice,
                                            color: Colors.black,
                                            size: 14),
                                        SizedBox(height: 30),
                                      ],
                                    ),
                                    Container(
                                      width: 80,
                                      child: ClipRRect(
                                        // borderRadius: BorderRadius.circular(50.0),
                                        child: Image.asset(
                                            'assets/ava_package.png'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              RegularText(
                                  text: widget.uid.note,
                                  color: Colors.black,
                                  size: 14),
                              Divider(),
                            ],
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
                            text: 'Rp. ${widget.uid.price}.00,-',
                            color: Colors.black,
                            size: 14),
                      ],
                    ),
                  ),
                  Divider(),

                  SizedBox(height: 20),
                  _showDataUser(context),

                  SizedBox(height: 20),
                  Container(
                    child: _name != null ? showData(context) : Container(),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )),
        )),
      ),
    );
  }

  Widget _showDataUser(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: PrimaryButton(
                color: primaryColour,
                text: 'Periksa data kamu dulu ya',
                onBtnPressed: () {
                  _loadUser();
                }),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //_loadData();
    //_loadUser();
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
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
        _image = value.data["image"].toString();
      });
    });
  }

  void _addTransaction(BuildContext context) async {
    final FormState form = _form.currentState;
    if (!form.validate()) {
    } else {
      try {
        form.save();
        Package package = Package(
          packagename: _packagename,
          price: int.tryParse(_price),
          note: _note,
          packagetype: _packagetype,
          packagebandwidth: _packagebandwidth,
          packagedevice: _packagedevice,
          packageiptv: _packageiptv,
          packagemodem: _packagemodem,
          packagefeature: _packagefeature,
          packagenetwork: _packagenetwork,
          name: _name,
          email: _email,
          date: _dateController.text,
          time: _timeController.text,
        );
        await FirestoreService().createTransaction(package);
        _move();
      } catch (e) {
        print(e);
      }
    }
  }

  void _move() {
    showInSnackBar('paket telah berhasil dibeli');

    new Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, "/landing", (route) => false);
    });
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

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    final Firestore firestore = Firestore.instance;
    firestore.collection("users").document(uid).get().then((value) {
      print(value.data);
      print(value.data["name"].toString());
      print(value.data["phone"].toString());
      print(value.data["email"].toString());
      print(value.data["data_package"].toString());
      setState(() {
        _name = value.data["name"].toString();
        _email = value.data["email"].toString();
        _phone = value.data["phone"].toString();
        _dataPackage = value.data["data_package"].toString();
      });
    });
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

  Widget showData(BuildContext context) {
    return Container(
      color: Colors.white12,
      child: Row(
        children: [
          Container(
            width: 80,
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(50.0),
              child: Image.asset('assets/ava_congrats.png'),
            ),
          ),
          SizedBox(width: 20),
          Container(
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Yeay !!',
                        style: TextStyle(
                            color: primaryColour,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Data kamu berhasil didapat',
                        style: TextStyle(
                            color: primaryColour,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      Text('Nama kamu : '),
                      Text(
                        _name ?? null,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('Email kamu : '),
                      Text(_email ?? null,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('Nomor Hp kamu : '),
                      Text('+62' + _phone ?? null,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Container(
                  child: PrimaryButton(
                      color: primaryColour,
                      text: 'Beli Paket Sekarang',
                      onBtnPressed: () {
                        // _showConfirmationDialog(context);
                        // Navigator.pushNamed(context, '/belipackage');
                        if (_dataPackage == 'Active') {
                          _showDialog(context);
                          print("paket aktif");
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BeliPackage(
                                        uid: widget.uid,
                                      )));
                        }
                      }),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) async {
    if (await _showConfirmationDialog(context)) {}
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              content: Container(
                  height: 420,
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Text(
                        "Paket kamu sudah aktif",
                        style: TextStyle(
                            color: primaryColour, fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        color: primaryColour,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.white30,
                              child: Container(
                                  width: 120,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Maaf $_name, sepertinya paket kamu sedang aktif"),
                                  )),
                            ),
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  'assets/ava_check.png',
                                  width: 110.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: primaryColour,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: primaryColour,
                          child: Container(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Silahkan menghubungi admin pada bagian call center",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      ),
                    ],
                  )),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.black,
                  child: Text("Terima kasih"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}
