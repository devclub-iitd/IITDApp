import 'package:iitd_app/utils/constants.dart';

class NewsModel {
  String id;
  String image;
  String title;
  String details;
  String sourcename;
  String author;
  DateTime createdAt;

  NewsModel(this.id, this.image, this.title, this.details, this.sourcename,
      this.author, this.createdAt);

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    var createdAt = DateTime.parse(json['createdAt']);
    return NewsModel(
        json["_id"].toString(),
        "${EndPoints.baseURL}/${json['imgUrl']}",
        json["title"].toString(),
        json["description"].toString(),
        json['sourcename'].toString(),
        json['author'].toString(),
        createdAt.toLocal());
  }
}
