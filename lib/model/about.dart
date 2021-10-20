class About {
  final String name;
  final String birth;
  final String npm;
  final String phone;
  final String prodi;
  final String universitas;
  final String version;

  About(
      {this.name,
      this.birth,
      this.npm,
      this.phone,
      this.prodi,
      this.universitas,
      this.version});

  About.fromMap(Map<String, dynamic> data)
      : name = data['name'],
        birth = data['birth'],
        npm = data['npm'],
        phone = data['phone'],
        prodi = data['prodi'],
        universitas = data['universitas'],
        version = data['version'];
}
