import 'package:biznet/dashboardAdmin/marketing/marketing_detail.dart';
import 'package:biznet/dashboardUser/marketingUser/marketing_user_detail.dart';
import 'package:biznet/model/marketing.dart';
import 'package:biznet/services/firestore_services.dart';
import 'package:biznet/widget/utils/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserMarketingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreService().getMarketing(),
      builder:
          (BuildContext context, AsyncSnapshot<List<MarketingModel>> snapshot) {
        if (snapshot.hasError || !snapshot.hasData)
          return CircularProgressIndicator();
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            MarketingModel marketingModel = snapshot.data[index];
            return Card(
              child: ListTile(
                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: marketingModel.img,
                          height: 190,
                         // width: 250,
                         width: MediaQuery.of(context).size.width,
                          placeholder: (context, url) => Container(
                            height: 190,
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
                    SizedBox(width: 10),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${marketingModel.title}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                marketingModel.body,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),

                // trailing: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: <Widget>[
                //     IconButton(
                //       color: Colors.red,
                //       icon: Icon(Icons.delete),
                //       onPressed: () =>
                //           _deleteTransaction(context, marketingModel.id),
                //     ),
                //   ],
                // ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MarketingUserDetail(
                      uid: marketingModel,
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
