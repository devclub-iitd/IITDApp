class Report{
  final String id;
  final String reporterId;
  final String description;
  final DateTime reportedAt;

  Report({this.id, this.reporterId, this.description, this.reportedAt});

  factory Report.fromJson(Map json){
    return Report(
      id:json['_id'],
      description:json['description'],
      reporterId:json['reporter'],
      reportedAt:DateTime.parse(json['date'])
    );
  }
}