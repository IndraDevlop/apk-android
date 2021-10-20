import 'package:biznet/dashboardUser/tagihan_user.dart/tagihan_user_detail.dart';
import 'package:biznet/model/package.dart';
import 'package:biznet/model/tagihan.dart';
import 'package:biznet/widget/user_tagihan_list_widget.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class UserTagihan extends StatefulWidget {
  UserTagihan({Key key, this.email}) : super(key: key);
  String email;

  @override
  _UserTagihanState createState() => _UserTagihanState();
}

class _UserTagihanState extends State<UserTagihan> {
  String email;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _email = prefs.getString('email');
    print(_email);
    setState(() {
      email = _email;
    });
  }

  Firestore _db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.height,
                      minHeight: 25.0),
                  child: StreamBuilder(
                    stream: _db
                        .collection('tagihan')
                        .where('email', isEqualTo: email)
                        .snapshots()
                        .map(
                          (snapshot) => snapshot.documents
                              .map(
                                (doc) =>
                                    Package.fromMap(doc.data, doc.documentID),
                              )
                              .toList(),
                        ),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Package>> snapshot) {
                      if (snapshot.hasError || !snapshot.hasData)
                        return CircularProgressIndicator();
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Package tagihan = snapshot.data[index];
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Card(
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('package name'),
                                    Text(
                                      '${tagihan.packagename}',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("owner : "),
                                        Text(
                                          tagihan.name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("email : "),
                                        Text(
                                          tagihan.email,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('tanggal aktif'),
                                        SizedBox(width: 5),
                                        Text(tagihan.date),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('waktu aktif'),
                                        SizedBox(width: 5),
                                        Text(tagihan.time),
                                      ],
                                    ),
                                   Row(
                                      children: [
                                        Text('status pembayaran'),
                                        SizedBox(width: 5),
                                        Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(tagihan.statusPayment, style: TextStyle(color: Colors.white)),
                                          )),
                                      ],
                                    ),
                                    SizedBox(height:5),
                                    Row(
                                      children: [
                                        Text('status device'),
                                        SizedBox(width: 5),
                                        Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(tagihan.statusDevice, style: TextStyle(color: Colors.white)),
                                          )),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TagihanUserDetail(
                                      uid: tagihan,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      ),
    ),
        ));
  }
}
