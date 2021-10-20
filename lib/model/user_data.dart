class UserData {
  final String name;
  final String type;
  final String email;
  final int phone;
  final String address;
  final String dataPackage;
  final String uid;


  UserData({this.name, this.type, this.email,this.phone, this.address ,this.dataPackage, this.uid});

  UserData.fromMap(Map<String,dynamic> data, String uid):
    name=data['name'],
    dataPackage=data['data_package'],
    type=data['type'],
    email=data['email'],
    address=data['address'],
    phone=data['phone'],
    uid=uid;

  Map<String, dynamic> toMap() {
    return {
      "name" : name,
      "address": address,
      "phone": phone,
      "email": email,
      "type":type,
      "data_package":dataPackage,
    };
  }

}