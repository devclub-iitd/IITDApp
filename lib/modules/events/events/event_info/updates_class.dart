class Update {
  String title;
  String message;
  DateTime dateTime;
  String id;

  Update({this.title, this.message, this.dateTime, this.id});

  factory Update.fromJson(Map<String, dynamic> json) {
    print(json["createdAt"]);
    //doing this because the time being stored in the db is 5.5 hours beehind for some reason
    DateTime dt = DateTime.parse(json["createdAt"]).add(Duration(hours: 5, minutes: 30));
    return Update(
      title: json["title"],
      message: json["body"],
      dateTime: dt,
      id: json["_id"]
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = title;
    map["body"] = message;
    return map;
  }
}

var dummyUpdate = Update(
    message: 'The event has been postponed and will now start at 9:00 PM',
    dateTime: DateTime.parse("2019-01-17 20:18"));

List<Update> dummyUpdates = [
  dummyUpdate,
  dummyUpdate,
  dummyUpdate,
];
