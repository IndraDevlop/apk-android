class UpdateTagihan {
  final String payment;
  final String device;

  final String id;

  UpdateTagihan({this.payment, this.device, this.id});

  UpdateTagihan.fromMap(Map<String, dynamic> data, String id)
      : 
      payment = data['status_payment'],
      device = data['status_device'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "status_payment": payment,
      "status_device": device,
    };
  }
}
