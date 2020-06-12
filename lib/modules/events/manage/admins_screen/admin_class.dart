class Admin {
  String name;
  String email;
  String clubName;
  String cubId;
  // String requestId;

  Admin({this.name, this.clubName, this.cubId, this.email});

  factory Admin.fromJson(Map<String,dynamic> json) {
    return Admin(
      name: json['name'],
      clubName: json['club'],
      email: json['email'],
    );
  }
}