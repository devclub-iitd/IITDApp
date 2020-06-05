class Request {
  String name;
  String email;
  String clubName;
  String cubId;
  String requestId;

  Request({this.name, this.requestId, this.clubName, this.cubId, this.email});

  factory Request.fromJson(Map<String,dynamic> json) {
    return Request(
      name: json['name'],
      requestId: json['id'],
      clubName: json['club'],
      email: json['email'],
    );
  }
}