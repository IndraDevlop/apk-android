import 'package:biznet/dashboardAdmin/marketing/marketing_detail.dart';
import 'package:biznet/dashboardUser/tagihan_user.dart/tagihan_user_detail.dart';
import 'package:biznet/model/marketing.dart';
import 'package:biznet/model/package.dart';
import 'package:biznet/model/tagihan.dart';
import 'package:biznet/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserTagihanListWidget extends StatelessWidget {
  UserTagihanListWidget({Key key, this.email}) : super(key: key);
  final String email;

  Firestore _db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _db
          .collection('tagihan')
          .where(
            'email',
            isEqualTo: email,
          )
          .snapshots()
          .map(
            (snapshot) => snapshot.documents
                .map(
                  (doc) => Package.fromMap(doc.data, doc.documentID),
                )
                .toList(),
          ),
      builder: (BuildContext context, AsyncSnapshot<List<Package>> snapshot) {
        if (snapshot.hasError || !snapshot.hasData)
          return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Package tagihan = snapshot.data[index];
            return Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text('package name'),
                    Text(
                      '"${tagihan.packagename}"',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("owner : "),
                        Text(
                          tagihan.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("email : "),
                        Text(
                          tagihan.email,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tagihan.date),
                    Text(tagihan.time),
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
            );
          },
        );
      },
    );
  }

  void _deleteTransaction(BuildContext context, String id) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await FirestoreService().deleteTransaction(id);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("Are you sure you want to delete?"),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("Delete"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}
