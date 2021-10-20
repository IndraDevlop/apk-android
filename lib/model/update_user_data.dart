class UpdateUserData {
  final String dataPackage;
  final String uid;

  UpdateUserData({this.dataPackage, this.uid});

  UpdateUserData.fromMap(Map<String, dynamic> data, String uid)
      : dataPackage = data['data_package'],
        uid = uid;

  Map<String, dynamic> toMap() {
    return {
      "data_package": dataPackage,
    };
  }
}
