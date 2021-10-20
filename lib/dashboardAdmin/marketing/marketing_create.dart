import 'dart:io';

import 'package:biznet/model/marketing.dart';
import 'package:biznet/services/firestore_services.dart';
import 'package:biznet/widget/primary_button.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketingCreate extends StatefulWidget {
  @override
  _MarketingCreateState createState() => _MarketingCreateState();
}

class _MarketingCreateState extends State<MarketingCreate> {
  final Color _primaryColour = primaryColour;
  final Color orange = Color(0xfff335da1);

  final String title = 'Create Marketing BizNet';

  final String textDateTime = "Date Time :";

  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  final TextEditingController titleController = new TextEditingController();
  final TextEditingController subtitleController = new TextEditingController();
  final TextEditingController bodyController = new TextEditingController();

  String _uid = '';
  String staff = '';
  String email = '';
  String phone = '';
  String address = '';
  String imgLoc;

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/homeadmin", (route) => false);
          },
        ),
      ),
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
            child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: 'Author',
                          hintText: staff,
                          counterText: '$staff'),
                    ),
                    SizedBox(height: 10),
                    Container(
                      // height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 10.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _imageFile != null
                              ? Image.file(_imageFile)
                              : GestureDetector(
                                  onTap: () {
                                    pickImage();
                                  },
                                  child: Column(
                                    children: [
                                      Text('Post your image here'),
                                      SizedBox(height: 5),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50.0),
                                        child: Image.asset('assets/no_image.png'),
                                      ),
                                    ],
                                  )
                                )),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Title marketing cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Title Marketing',
                          counterText: 'Promotion with new package'),
                    ),
                    TextFormField(
                      controller: subtitleController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Sub-title marketing cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Sub-title Marketing',
                          counterText: 'just pre-order'),
                    ),
                    TextFormField(
                      controller: bodyController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Body marketing cannot be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Body Content Marketing',
                          counterText: 'BizNet is provider with..'),
                    ),
                    SizedBox(height: 20),
                    submit(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    final Firestore firestore = Firestore.instance;
    firestore.collection("users").document(uid).get().then((value) {
      print(value.data);
      print(uid);
      print(value.data["name"].toString());
      print(value.data["phone"].toString());
      print(value.data["email"].toString());
      print(value.data["address"].toString());
      setState(() {
        staff = value.data["name"].toString();
        phone = value.data["phone"].toString();
        email = value.data["email"].toString();
        address = value.data["address"].toString();
        _uid = uid;
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

  Future _createContent(BuildContext context) async {
    final FormState form = _form.currentState;
    if (!form.validate()) {
      showInSnackBar('Please insert the red line before submitting.');
    } else {
      try {
        form.save();
        String fileName = basename(_imageFile.path);
        StorageReference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('marketing/$fileName');
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        print(downloadUrl);
        MarketingModel marketing = MarketingModel(
          author: staff,
          title: titleController.text,
          subtitle: subtitleController.text,
          body: bodyController.text,
          date: _dateController.text,
          time: _timeController.text,
          img: downloadUrl,
        );

        await FirestoreService().createMarketing(marketing);
        showInSnackBar('Content has been created by. $staff');
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

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile == null){
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
              onPressed: () => _createContent(context),
              child: Text(
                "Create Marketing",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _loadUser();
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }
}
