class User {
  final String name;
  final String type;
  final String email;
  final int phone;
  final String address;
  final String uid;
  final String rekeningBCA;
  final String rekeningMandiri;

  User({this.name, this.type, this.email,this.phone, this.address ,this.rekeningBCA,this.rekeningMandiri, this.uid});

  User.fromMap(Map<String,dynamic> data, String uid):
    name=data['name'],
    type=data['type'],
    email=data['email'],
    address=data['address'],
    phone=data['phone'],
    rekeningBCA=data['rekening_bca'],
    rekeningMandiri=data['rekening_mandiri'],
    uid=uid;

  Map<String, dynamic> toMap() {
    return {
      "name" : name,
      "address": address,
      "phone": phone,
      "rekening_bca": phone,
      "rekening_mandiri": phone,
    };
  }

}