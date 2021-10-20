class UpdateBukti {
  final String img;

  final String id;

  UpdateBukti({this.img, this.id});

  UpdateBukti.fromMap(Map<String, dynamic> data, String id)
      : 
      img = data['image'],

        id = id;

  Map<String, dynamic> toMap() {
    return {
      "image": img,

    };
  }
}
