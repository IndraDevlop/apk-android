class Package {
  final String packagename;
  final String packagetype;
  final String statusPayment;
  final String statusDevice;
  final String packagebandwidth;
  final String packagefeature;
  final String packagedevice;
  final String packagemodem;
  final String packageiptv;
  final String packagenetwork;
  final String note;
  final String email;
  final String name;
  final String date;
  final String time;
  final String img;
  final String uid;
  final String uidTagihan;
  final String uidTransaksi;
  final int price;

  final String id;

  Package(
      {this.packagename,
      this.packagetype,
      this.statusPayment,
      this.statusDevice,
      this.packagebandwidth,
      this.packagefeature,
      this.packagedevice,
      this.packageiptv,
      this.packagemodem,
      this.packagenetwork,
      this.note,
      this.price,
      this.email,
      this.name,
      this.date,
      this.time,
      this.img,
      this.uid,
      this.uidTagihan,
      this.uidTransaksi,
      this.id});

  Package.fromMap(Map<String, dynamic> data, String id)
      : packagename = data['package_name'],
        packagetype = data['package_type'],
        statusPayment = data['status_payment'],
        statusDevice = data['status_device'],
        packagebandwidth = data['package_bandwidth'],
        packagefeature = data['package_feature'],
        packagedevice = data['package_device'],
        packageiptv = data['package_iptv'],
        packagemodem = data['package_modem'],
        packagenetwork = data['package_network'],
        note = data['note'],
        price = data['price'],
        name = data['name'],
        email = data['email'],
        date = data['date'],
        time = data['time'],
        img = data['image'],
        uid = data['uid'],
        uidTagihan = data['uid_tagihan'],
        uidTransaksi = data['uid_transaksi'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "package_name": packagename,
      "package_type": packagetype,
      "status_payment": statusPayment,
      "status_device": statusDevice,
      "package_bandwidth": packagebandwidth,
      "package_feature": packagefeature,
      "package_device": packagedevice,
      "package_iptv": packageiptv,
      "package_modem": packagemodem,
      "package_network": packagenetwork,
      "note": note,
      "price": price,
      "name": name,
      "email": email,
      "date": date,
      "image": img,
      "time": time,
      "uid": uid,
      "uid_tagihan": uidTagihan,
      "uid_transaksi": uidTransaksi,
    };
  }
}
