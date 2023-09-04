import 'package:iitd_app/utils/constants.dart';

class LostandFoundModel {
  String id;
  String name;
  DateTime createdAt;
  String? imgUrl;
  String place;
  LostandFoundStatus status;
  String description;

  LostandFoundModel({
    required this.id,
    required this.name,
    required this.createdAt,
    this.imgUrl,
    required this.place,
    required this.status,
    required this.description,
  });

  LostandFoundModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    String? imgUrl,
    String? place,
    LostandFoundStatus? status,
    String? description,
  }) {
    return LostandFoundModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      imgUrl: imgUrl ?? this.imgUrl,
      place: place ?? this.place,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  factory LostandFoundModel.fromJson(Map<String, dynamic> json) {
    var createdAt = DateTime.parse(json['createdAt']);
    return LostandFoundModel(
      id: json['_id'],
      name: json['name'],
      place: json['place'],
      status: (json['status'] == false)
          ? LostandFoundStatus.unclaimed
          : LostandFoundStatus.claimed,
      description: json['description'],
      imgUrl: json['imgUrl'],
      createdAt: createdAt.toLocal(),
    );
  }

  @override
  String toString() {
    return 'LostandFoundModel(id: $id, name: $name, createdAt: $createdAt, imgUrl: $imgUrl, place: $place, status: $status, description: $description)';
  }
}
