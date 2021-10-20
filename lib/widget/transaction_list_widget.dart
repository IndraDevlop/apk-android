import 'package:biznet/dashboardAdmin/package/package_detail.dart';
import 'package:biznet/dashboardAdmin/transaction/transaction_detail.dart';
import 'package:biznet/model/package.dart';
import 'package:biznet/model/tagihan.dart';
import 'package:biznet/model/update_tagihan.dart';
import 'package:biznet/model/update_user_data.dart';
import 'package:biznet/services/firestore_services.dart';
import 'package:flutter/material.dart';

class TransactionListWidget extends StatelessWidget {
  String _value;
  String updetan;
  String payment;
  String device;
  String _uid;
  String uidTransaksi;
  String uidTagihan;
  String uidUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreService().getTransaction(),
      builder: (BuildContext context, AsyncSnapshot<List<Package>> snapshot) {
        if (snapshot.hasError || !snapshot.hasData)
          return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            Package transaksi = snapshot.data[index];
            uidTransaksi = transaksi.uidTransaksi;
            print('uid transaksi : ' + uidTransaksi);
            uidTagihan = transaksi.uidTagihan!=null ? transaksi.uidTagihan:'';
            print('uid tagihan : ' + uidTagihan);
            _uid = transaksi.uid;
            print('_uid transaksi : ' + _uid);
            return Card(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${transaksi.name}'),
                    Text(
                      '"${transaksi.packagename}"',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("price : "),
                        Text(
                          transaksi.price.toString(),
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
                    Row(
                      children: [
                        Text("Type : "),
                        Text(transaksi.packagetype),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Status Network : "),
                        Text(transaksi.packagenetwork),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Status payment : "),
                        Text(transaksi.statusPayment),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Status device : "),
                        Text(transaksi.statusDevice),
                      ],
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        child: transaksi.statusPayment == 'Lunas'
                            ? new DropdownButton<String>(
                                hint: Text('Update status'),
                                items:
                                    <String>['Non-Active'].map((String _value) {
                                  return new DropdownMenuItem<String>(
                                    value: _value,
                                    child: new Text(_value),
                                  );
                                }).toList(),
                                onChanged: (_value) async {
                                  updetan = _value.toString();
                                  uidTagihan = transaksi.uidTagihan;
                                  uidTransaksi = transaksi.uidTransaksi;
                                  uidUser = transaksi.uid;
                                  print(_value);
                                  UpdateUserData userData = UpdateUserData(
                                    dataPackage: updetan,
                                  );

                                  await FirestoreService()
                                      .updateUserData(userData, uidUser);
                                  print('Status paket data sekarang : $_value');
                                  if (updetan == 'Non-Active') {
                                    payment = 'Belum bayar';
                                    device = 'Non-Active';
                                    print(payment);
                                  } else {
                                    payment = 'Lunas';
                                    device = 'Active';
                                    print(payment);
                                  }
                                  UpdateTagihan updateData = UpdateTagihan(
                                    payment: payment,
                                    device: device,
                                  );
                                  print(uidUser);
                                  await FirestoreService().updateTagihanData(
                                      updateData, uidTagihan);
                                  await FirestoreService().updateTransaksiData(
                                      updateData, uidTransaksi);
                                      await FirestoreService().updateTagihanUser(updateData, uidUser);

                                },
                              )
                            : Container()),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () =>
                          _deleteTransaction(context, transaksi.id),
                    ),
                  ],
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TransactionDetail(
                      uid: transaksi,
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
        await FirestoreService().deleteTransaksi(id);
        await FirestoreService().deleteTagihan(uidTagihan);
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
