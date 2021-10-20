import 'package:biznet/model/marketing.dart';
import 'package:biznet/model/package.dart';
import 'package:biznet/model/tagihan.dart';
import 'package:biznet/model/update_bukti.dart';
import 'package:biznet/model/update_tagihan.dart';
import 'package:biznet/model/update_user_data.dart';
import 'package:biznet/model/user.dart';
import 'package:biznet/model/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  Firestore _db = Firestore.instance;

  String uid;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  // Stream<List<User>> getUser() {
  //   return _db.collection('partner').snapshots().map(
  //         (snapshot) => snapshot.documents.map(
  //           (doc) => User.fromMap(doc.data, doc.documentID),
  //         ).toList(),
  //       );
  // }

  // Future<void> addUser(User user) {
  //   return _db.collection('users').add(user.toMap());
  // }

  // Future<void> deleteUser(String id) {
  //   return _db.collection('users').document(id).delete();
  // }

  Future<void> updateUser(User user) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String uid = prefs.getString('uid');
    // print(uid);
    return _db.collection('about').document('profile').updateData(user.toMap());
  }

  Future<void> updateUserDataPackage(UserData user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    print(uid);
    return _db.collection('users').document(uid).updateData(user.toMap());
  }

  //Marketing

  Future<void> createMarketing(MarketingModel marketing) {
    return _db.collection('marketing').add(marketing.toMap());
  }

  Stream<List<MarketingModel>> getMarketing() {
    return _db.collection('marketing').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => MarketingModel.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> deleteTransaction(String id) {
    return _db.collection('marketing').document(id).delete();
  }

  //Package

  Stream<List<Package>> getPackage() {
    return _db.collection('package').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Package.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> createPackage(Package package) {
    return _db.collection('package').add(package.toMap());
  }

  Future<void> deletePackage(String id) {
    return _db.collection('package').document(id).delete();
  }

  //Transaction

  Stream<List<Package>> getTransaction() {
    return _db.collection('transaksi').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Package.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Future<void> createTransaction(Package package) {
    return _db.collection('transaksi').add(package.toMap());
  }

  Future<void> createTagihan(Package package) {
    return _db.collection('tagihan').add(package.toMap());
  }

  Future<void> deleteTagihan(String uidTagihan) {
    return _db.collection('tagihan').document(uidTagihan).delete();
  }

  Future<void> deleteTransaksi(String id) {
    return _db.collection('transaksi').document(id).delete();
  }

  Future<void> updateTransaksi(Package package) {
    return _db
        .collection('transaksi')
        .document(package.id)
        .updateData(package.toMap());
  }

  Future<void> updateTagihan(Package package, String _uidTagihan) {
    return _db
        .collection('tagihan')
        .document(_uidTagihan)
        .updateData(package.toMap());
  }

  Future<void> updateUserTagihan(UpdateTagihan tagihan) {
    return _db
        .collection('tagihan')
        .document(tagihan.id)
        .updateData(tagihan.toMap());
  }

  Future<void> updateUserData(UpdateUserData userData, String _uid) async {
    return _db.collection('users').document(_uid).updateData(userData.toMap());
  }
  Future<void> updateTagihanUser(UpdateTagihan updateData, String uidUser) async{
    return _db.collection('users').document(uidUser).updateData(updateData.toMap());
  }
  Future<void> updateTagihanData(UpdateTagihan updateData, String uidTagihan) async {
    return _db.collection('tagihan').document(uidTagihan).updateData(updateData.toMap());
  }
  Future<void> updateTransaksiData(UpdateTagihan updateData, String uidTransaksi) async {
    return _db.collection('transaksi').document(uidTransaksi).updateData(updateData.toMap());
  }
  Future<void> updateBuktiTransaksi(UpdateBukti bukti, String uidTransaksi) async {
    return _db.collection('transaksi').document(uidTransaksi).updateData(bukti.toMap());
  }
  Future<void> updateBuktiTagihan(UpdateBukti bukti, String uidTransaksi) async {
    return _db.collection('tagihan').document(uidTransaksi).updateData(bukti.toMap());
  }
}
