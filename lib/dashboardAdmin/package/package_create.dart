import 'dart:io';

import 'package:biznet/model/package.dart';
import 'package:biznet/services/firestore_services.dart';
import 'package:biznet/widget/primary_button.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class PackageCreate extends StatefulWidget {
  @override
  _PackageCreateState createState() => _PackageCreateState();
}

class _PackageCreateState extends State<PackageCreate> {
  final Color _primaryColour = primaryColour;

  final Color orange = Color(0xfff335da1);

  final String title = 'Create Package BizNet';

  String typePackage = 'Select package';
  String featurePackage = 'Select feature';
  String bandwidthPackage = 'Select bandwidth';
  String devicePackage = 'Select device';
  String modemPackage = 'Select modem';
  String iptvPackage = 'Select iptv';
  String networkPackage = 'Select network';
  String note;
  String packagename;
  String price;

  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController packagenameController =
      new TextEditingController();
  final TextEditingController priceController = new TextEditingController();
  final TextEditingController noteController = new TextEditingController();

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
                      TextFormField(
                        controller: packagenameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Package name cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Package Name',
                            counterText: 'Regular Package Biz.Net'),
                      ),
                      TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Price cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Price', counterText: '150000'),
                      ),
                      //Type package
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Type",
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                                height: 80,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection("typePackage")
                                        .snapshots(),
                                    // ignore: missing_return
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        const Text("Loading.....");
                                      } else {
                                        List<DropdownMenuItem>
                                            typePackageItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.documents.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.documents[i];
                                          typePackageItems.add(
                                            DropdownMenuItem(
                                              child: Text(
                                                snap.documentID,
                                                style: TextStyle(
                                                    color: primaryColour),
                                              ),
                                              value: "${snap.documentID}",
                                            ),
                                          );
                                        }
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(width: 50.0),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                items: typePackageItems,
                                                onChanged: (typePackageValue) {
                                                  final snackBar = SnackBar(
                                                    backgroundColor:
                                                        primaryColour,
                                                    content: Text(
                                                      'anda memilih tipe paket $typePackageValue',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                  Scaffold.of(context)
                                                      .showSnackBar(snackBar);
                                                  setState(() {
                                                    typePackage =
                                                        typePackageValue;
                                                  });
                                                },
                                                // value: selectedCurrency,
                                                isExpanded: false,
                                                hint: new Text(
                                                      "$typePackage",
                                                    ) ??
                                                    Container(),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    })),
                          ],
                        ),
                      ),
                      //feature
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Feature",
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                                height: 80,
                                // width: 215,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection("feature")
                                        .snapshots(),
                                    // ignore: missing_return
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        const Text("Loading.....");
                                      } else {
                                        List<DropdownMenuItem>
                                            featurePackageItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.documents.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.documents[i];
                                          featurePackageItems.add(
                                            DropdownMenuItem(
                                              child: Text(
                                                snap.documentID,
                                                style: TextStyle(
                                                    color: primaryColour),
                                              ),
                                              value: "${snap.documentID}",
                                            ),
                                          );
                                        }
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(width: 50.0),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                items: featurePackageItems,
                                                onChanged:
                                                    (featurePackageValue) {
                                                  final snackBar = SnackBar(
                                                    backgroundColor:
                                                        primaryColour,
                                                    content: Text(
                                                      'anda memilih fitur $featurePackageValue',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                  Scaffold.of(context)
                                                      .showSnackBar(snackBar);
                                                  setState(() {
                                                    featurePackage =
                                                        featurePackageValue;
                                                  });
                                                },
                                                // value: selectedCurrency,
                                                isExpanded: false,
                                                hint: new Text(
                                                      "$featurePackage",
                                                    ) ??
                                                    Container(),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    })),
                          ],
                        ),
                      ),
                      //bandwidth
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Bandwidth",
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                                height: 80,
                                // width: 215,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection("bandwidth")
                                        .snapshots(),
                                    // ignore: missing_return
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        const Text("Loading.....");
                                      } else {
                                        List<DropdownMenuItem>
                                            bandwidthPackageItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.documents.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.documents[i];
                                          bandwidthPackageItems.add(
                                            DropdownMenuItem(
                                              child: Text(
                                                snap.documentID,
                                                style: TextStyle(
                                                    color: primaryColour),
                                              ),
                                              value: "${snap.documentID}",
                                            ),
                                          );
                                        }
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(width: 50.0),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                items: bandwidthPackageItems,
                                                onChanged:
                                                    (bandwidthPackageValue) {
                                                  final snackBar = SnackBar(
                                                    backgroundColor:
                                                        primaryColour,
                                                    content: Text(
                                                      'anda memilih bandwidth $bandwidthPackageValue',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                  Scaffold.of(context)
                                                      .showSnackBar(snackBar);
                                                  setState(() {
                                                    bandwidthPackage =
                                                        bandwidthPackageValue;
                                                  });
                                                },
                                                // value: selectedCurrency,
                                                isExpanded: false,
                                                hint: new Text(
                                                      "$bandwidthPackage",
                                                    ) ??
                                                    Container(),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    })),
                          ],
                        ),
                      ),

                      //modem
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Modem",
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                                height: 80,
                                // width: 215,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection("modem")
                                        .snapshots(),
                                    // ignore: missing_return
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        const Text("Loading.....");
                                      } else {
                                        List<DropdownMenuItem>
                                            modemPackageItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.documents.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.documents[i];
                                          modemPackageItems.add(
                                            DropdownMenuItem(
                                              child: Text(
                                                snap.documentID,
                                                style: TextStyle(
                                                    color: primaryColour),
                                              ),
                                              value: "${snap.documentID}",
                                            ),
                                          );
                                        }
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(width: 50.0),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                items: modemPackageItems,
                                                onChanged: (modemPackageValue) {
                                                  final snackBar = SnackBar(
                                                    backgroundColor:
                                                        primaryColour,
                                                    content: Text(
                                                      'anda memilih modem $modemPackageValue',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                  Scaffold.of(context)
                                                      .showSnackBar(snackBar);
                                                  setState(() {
                                                    modemPackage =
                                                        modemPackageValue;
                                                  });
                                                },
                                                // value: selectedCurrency,
                                                isExpanded: false,
                                                hint: new Text(
                                                      "$modemPackage",
                                                    ) ??
                                                    Container(),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    })),
                          ],
                        ),
                      ),
                      //IPTV
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "IPTV",
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                                height: 80,
                                // width: 215,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection("IPTV")
                                        .snapshots(),
                                    // ignore: missing_return
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        const Text("Loading.....");
                                      } else {
                                        List<DropdownMenuItem>
                                            iptvPackageItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.documents.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.documents[i];
                                          iptvPackageItems.add(
                                            DropdownMenuItem(
                                              child: Text(
                                                snap.documentID,
                                                style: TextStyle(
                                                    color: primaryColour),
                                              ),
                                              value: "${snap.documentID}",
                                            ),
                                          );
                                        }
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(width: 50.0),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                items: iptvPackageItems,
                                                onChanged: (iptvPackageValue) {
                                                  final snackBar = SnackBar(
                                                    backgroundColor:
                                                        primaryColour,
                                                    content: Text(
                                                      'anda memilih iptv $iptvPackageValue',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                  Scaffold.of(context)
                                                      .showSnackBar(snackBar);
                                                  setState(() {
                                                    iptvPackage =
                                                        iptvPackageValue;
                                                  });
                                                },
                                                // value: selectedCurrency,
                                                isExpanded: false,
                                                hint: new Text(
                                                      "$iptvPackage",
                                                    ) ??
                                                    Container(),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    })),
                          ],
                        ),
                      ),
                      //Network
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Network",
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                                height: 80,
                                // width: 215,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection("network")
                                        .snapshots(),
                                    // ignore: missing_return
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        const Text("Loading.....");
                                      } else {
                                        List<DropdownMenuItem>
                                            networkPackageItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.documents.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.documents[i];
                                          networkPackageItems.add(
                                            DropdownMenuItem(
                                              child: Text(
                                                snap.documentID,
                                                style: TextStyle(
                                                    color: primaryColour),
                                              ),
                                              value: "${snap.documentID}",
                                            ),
                                          );
                                        }
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(width: 50.0),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                items: networkPackageItems,
                                                onChanged:
                                                    (networkPackageValue) {
                                                  final snackBar = SnackBar(
                                                    backgroundColor:
                                                        primaryColour,
                                                    content: Text(
                                                      'anda memilih network $networkPackageValue',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                  Scaffold.of(context)
                                                      .showSnackBar(snackBar);
                                                  setState(() {
                                                    networkPackage =
                                                        networkPackageValue;
                                                  });
                                                },
                                                // value: selectedCurrency,
                                                isExpanded: false,
                                                hint: new Text(
                                                      "$networkPackage",
                                                    ) ??
                                                    Container(),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    })),
                          ],
                        ),
                      ),
                      //device range
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Range Device",
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                                height: 80,
                                // width: 215,
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection("device")
                                        .snapshots(),
                                    // ignore: missing_return
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        const Text("Loading.....");
                                      } else {
                                        List<DropdownMenuItem>
                                            devicePackageItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.documents.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.documents[i];
                                          devicePackageItems.add(
                                            DropdownMenuItem(
                                              child: Text(
                                                snap.documentID,
                                                style: TextStyle(
                                                    color: primaryColour),
                                              ),
                                              value: "${snap.documentID}",
                                            ),
                                          );
                                        }
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(width: 50.0),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                items: devicePackageItems,
                                                onChanged:
                                                    (devicePackageValue) {
                                                  final snackBar = SnackBar(
                                                    backgroundColor:
                                                        primaryColour,
                                                    content: Text(
                                                      'anda memilih range device $devicePackageValue',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                  Scaffold.of(context)
                                                      .showSnackBar(snackBar);
                                                  setState(() {
                                                    devicePackage =
                                                        devicePackageValue;
                                                  });
                                                },
                                                // value: selectedCurrency,
                                                isExpanded: false,
                                                hint: new Text(
                                                      "$devicePackage",
                                                    ) ??
                                                    Container(),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    })),
                          ],
                        ),
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
                      //Note
                      TextFormField(
                        controller: noteController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Note cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Note',
                            counterText: 'lebih dari 50 channel'),
                      ),
                     submit(context),
                    ],
                  ),
                )),
          ),
        ),
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
              onPressed: () => _createPackage(context),
              child: Text(
                "Create Package",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
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

  Future _createPackage(BuildContext context) async {
    final FormState form = _form.currentState;
    if (!form.validate()) {
      showInSnackBar('Please insert the red line before submitting.');
    } else {
      try {
        form.save();
         String fileName = basename(_imageFile.path);
        StorageReference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('package/$fileName');
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        print(downloadUrl);
        Package package = Package(
          packagename: packagenameController.text,
          price: int.tryParse(priceController.text),
          note: noteController.text,
          packagetype: typePackage,
          packagebandwidth: bandwidthPackage,
          packagedevice: devicePackage,
          packageiptv: iptvPackage,
          packagemodem: modemPackage,
          packagefeature: featurePackage,
          packagenetwork: networkPackage,
          img: downloadUrl,
        );
        await FirestoreService().createPackage(package);
        showInSnackBar('Package has been created');
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
}
