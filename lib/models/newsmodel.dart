import 'package:iitd_app/utils/constants.dart';

class NewsModel {
  String id;
  String image;
  String title;
  String details;

  NewsModel(this.id, this.image, this.details, this.title);

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(json["_id"].toString(), "https://iitdconnect-server.devclub.in/${json['imgUrl']}", json["title"].toString(), json["description"].toString());
  }
}
