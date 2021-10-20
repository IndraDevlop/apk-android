import 'package:biznet/model/package.dart';
import 'package:biznet/model/tagihan.dart';
import 'package:biznet/model/update_user_data.dart';
import 'package:biznet/model/user_data.dart';
import 'package:biznet/services/firestore_services.dart';
import 'package:biznet/widget/primary_button.dart';
import 'package:biznet/widget/primary_text.dart';
import 'package:biznet/widget/regular_text.dart';
import 'package:biznet/widget/secondary_text.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionDetail extends StatefulWidget {
  TransactionDetail({Key key, this.uid}) : super(key: key);
  final Package uid;

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  String _name = '';
  String _email = '';
  String _uid = '';
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

  String _statusActive = 'Active';
  String _statusDibayar = 'Lunas';

  String _image;

  String _uidTagihan;

  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
          child: Container(
        //height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        height: 640,
        width: 360,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                        Text('Status Payment'),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            RegularText(
                                text: widget.uid.statusPayment,
                                color: Colors.black,
                                size: 14),
                          ],
                        ),
                        Text('Status Device'),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            RegularText(
                                text: widget.uid.statusDevice,
                                color: Colors.black,
                                size: 14),
                          ],
                        ),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            //width: 250,
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    // width: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Owner :'),
                                        SizedBox(height: 2),
                                        RegularText(
                                            text: widget.uid.name,
                                            color: Colors.black,
                                            size: 16),
                                        SizedBox(height: 15),
                                        Text('Email Owner :'),
                                        SizedBox(height: 2),
                                        RegularText(
                                            text: widget.uid.email,
                                            color: Colors.black,
                                            size: 16),
                                        SizedBox(height: 20),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Tagihan',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(width: 10),
                                              SecondaryText(
                                                  text:
                                                      'Rp. ${widget.uid.price}.00,-',
                                                  color: Colors.black,
                                                  size: 14),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Container(child:
                                         widget.uid.statusPayment != 'Lunas' ?
                                         _showDataUser(context) : Container()
                                         ),
                                        SizedBox(height: 20),
                                        Center(
                                          child: Container(
                                            child: _image != null
                                                ? Center(
                                                    child: Container(
                                                        // height: 350,
                                                        child:
                                                            showData(context)),
                                                  )
                                                : Container(),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        )),
      )),
    );
  }

  Widget _showDataUser(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: PrimaryButton(
                color: primaryColour,
                text: 'Tampilkan Bukti Pembayaran',
                onBtnPressed: () {
                  _loadUser();
                }),
          ),
        ],
      ),
    );
  }

  Widget _updateKeTagihan(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: PrimaryButton(
                color: primaryColour,
                text: 'Aktifkan paket',
                onBtnPressed: () {
                  if(widget.uid.uidTagihan == null){
                  _aktifkanPaket(context);
                  }
                  else {
                    _updatePaket(context);
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget showData(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: primaryColour),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl: widget.uid.img,
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
                              height: 25, child: CircularProgressIndicator()),
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
          SizedBox(height: 10),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Pastikan tagihan sesuai dengan bukti pembayaran',
              style:
                  TextStyle(color: primaryColour, fontWeight: FontWeight.bold),
            ),
          )),
          SizedBox(height: 5),
          _updateKeTagihan(context),
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

  Future _aktifkanPaket(BuildContext context) async {
    final FormState form = _form.currentState;
    if (!form.validate()) {
      showInSnackBar('Please insert the red line before submitting.');
    } else {
      try {
        form.save();

        
        final collRef = Firestore.instance.collection('tagihan');
        DocumentReference docReference = collRef.document();

        docReference.setData({
          'name': _name,
          'email': _email,
          'uid': widget.uid.uid,
          'uid_transaksi': widget.uid.id,
          'uid_tagihan': docReference.documentID,
          'status_payment': _statusActive,
          'status_device': _statusDibayar,
          'package_name': widget.uid.packagename,
          'price': int.tryParse(widget.uid.price.toString()),
          'package_type': widget.uid.packagetype,
          'package_bandwidth': widget.uid.packagebandwidth,
          'package_device': widget.uid.packagedevice,
          'package_iptv': widget.uid.packageiptv,
          'package_modem': widget.uid.packagemodem,
          'package_feature': widget.uid.packagefeature,
          'package_network': widget.uid.packagenetwork,
          'date': widget.uid.date,
          'time': widget.uid.time,
          'image': widget.uid.img,
        }).then((doc) {
          print('get ${docReference.documentID}');
        }).catchError((error) {
          print(error);
        });

        Package package = Package(
          id: widget.uid.id,
          uid: widget.uid.uid,
          uidTransaksi: widget.uid.id,
          uidTagihan: docReference.documentID,
          statusDevice: _statusActive,
          statusPayment: _statusDibayar,
          name: _name,
          email: _email,
          packagename: widget.uid.packagename,
          price: int.tryParse(widget.uid.price.toString()),
          packagetype: widget.uid.packagetype,
          packagebandwidth: widget.uid.packagebandwidth,
          packagedevice: widget.uid.packagedevice,
          packageiptv: widget.uid.packageiptv,
          packagemodem: widget.uid.packagemodem,
          packagefeature: widget.uid.packagefeature,
          packagenetwork: widget.uid.packagenetwork,
          date: widget.uid.date,
          time: widget.uid.time,
          img: widget.uid.img,
        );
        UpdateUserData userData = UpdateUserData(
          dataPackage: _statusActive,
        );
        setState(() {
          _uid = widget.uid.uid;
        });
        await FirestoreService().updateUserData(userData, _uid);
        await FirestoreService().updateTransaksi(package);

        print(_statusActive);
        print(_statusDibayar);

        showInSnackBar('Paket ${widget.uid.name} sudah aktif');
        new Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
              context, "/homeadmin", (route) => false);
        });
      } catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        showInSnackBar(e.message);
      }
    }
  }

  Future _updatePaket(BuildContext context) async {
    final FormState form = _form.currentState;
    if (!form.validate()) {
      showInSnackBar('Please insert the red line before submitting.');
    } else {
      try {
        form.save();


        Package package = Package(
          id: widget.uid.id,
          uid: widget.uid.uid,
          uidTransaksi: widget.uid.id,
          uidTagihan: widget.uid.uidTagihan,
          statusDevice: _statusActive,
          statusPayment: _statusDibayar,
          name: _name,
          email: _email,
          packagename: widget.uid.packagename,
          price: int.tryParse(widget.uid.price.toString()),
          packagetype: widget.uid.packagetype,
          packagebandwidth: widget.uid.packagebandwidth,
          packagedevice: widget.uid.packagedevice,
          packageiptv: widget.uid.packageiptv,
          packagemodem: widget.uid.packagemodem,
          packagefeature: widget.uid.packagefeature,
          packagenetwork: widget.uid.packagenetwork,
          date: widget.uid.date,
          time: widget.uid.time,
          img: widget.uid.img,
        );
        UpdateUserData userData = UpdateUserData(
          dataPackage: _statusActive,
        );
        setState(() {
          _uid = widget.uid.uid;
          _uidTagihan = widget.uid.uidTagihan;
        });
        await FirestoreService().updateUserData(userData, _uid);
        await FirestoreService().updateTransaksi(package);
        await FirestoreService().updateTagihan(package, _uidTagihan);

        print(_statusActive);
        print(_statusDibayar);

        showInSnackBar('Paket ${widget.uid.name} berhasil terupdate');
        new Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
              context, "/homeadmin", (route) => false);
        });
      } catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        showInSnackBar(e.message);
      }
    }
  }

  void _loadUser() async {
    final Firestore firestore = Firestore.instance;
    firestore
        .collection("transaksi")
        .document(widget.uid.id)
        .get()
        .then((value) {
      print(value.data);
      print(value.data["name"].toString());
      print(value.data["phone"].toString());
      print(value.data["email"].toString());
      print(value.data["image"].toString());
      setState(() {
        _name = value.data["name"].toString();
        _email = value.data["email"].toString();
        _image = value.data["image"].toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // _loadData();
  }

  void _loadData() async {
    final Firestore firestore = Firestore.instance;
    firestore
        .collection("transaksi")
        .document(widget.uid.id)
        .get()
        .then((value) {
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
