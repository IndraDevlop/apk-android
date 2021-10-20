class MarketingModel {
  final String author;
  final String title;
  final String subtitle;
  final String body;
  final String date;
  final String time;
  final String id;
  final String img;

  MarketingModel({this.author, this.title, this.subtitle, this.body, this.date, this.time, this.img, this.id});

  MarketingModel.fromMap(Map<String,dynamic> data, String id):
    author=data['author'],
    title=data['title'],
    subtitle=data['subtitle'],
    body=data['body'],
    date=data['date'],
    time=data['time'],
    img=data['image'],
    id=id;

  Map<String, dynamic> toMap() {
    return {
      "author" : author,
      "title":title,
      "subtitle":subtitle,
      "body":body,
      "date":date,
      "time":time,
      "image":img,
    };
  }

}