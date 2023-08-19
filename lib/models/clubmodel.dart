class Club {
  String clubName;
  String? clubAbout;
  bool isSubbed;
  String id;

  Club(
      {required this.clubName,
      this.clubAbout,
      this.isSubbed = false,
      required this.id});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
        clubName: json['body']['name'],
        clubAbout: json['body']['about'],
        isSubbed: json['isSub'],
        id: json['body']['_id']);
  }

  Map toMap() {
    var map = <String, dynamic>{};
    map['name'] = clubName;
    map['about'] = clubAbout;
    map['isSub'] = isSubbed.toString();
    return map;
  }
}
