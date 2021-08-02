import 'package:IITDAPP/modules/events/clubs/club_class.dart';

class User {
  String name;
  String email;
  String id;
  bool isAdmin;
  List<UClub> adminof;
  bool isSuperAdmin;
  List<UClub> superAdminOf;
  bool isSSAdmin;

  User({
    this.name,
    this.email,
    this.id,
    this.isAdmin,
    this.adminof,
    this.isSuperAdmin,
    this.superAdminOf,
    this.isSSAdmin = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // print("ADMINOF LENGTH: ${json["adminOf"].length}");
    var iA = (json['adminOf'].length + json['superAdminOf'].length > 0)
        ? true
        : false;
    var iSA = (json['superAdminOf'].length > 0) ? true : false;
    // bool iSA = false;
    // ignore: prefer_collection_literals
    var adminof = [];
    for (var i = 0; i < json['adminOf'].length; i++) {
      adminof.add(UClub.fromJson(json['adminOf'][i]));
    }
    // ignore: prefer_collection_literals
    var superadminof = [];
    for (var i = 0; i < json['superAdminOf'].length; i++) {
      var _uclub = UClub.fromJson(json['superAdminOf'][i]);
      if (adminof.contains(_uclub)) adminof.add(_uclub);
      superadminof.add(_uclub);
    }
    return User(
        name: json['name'],
        email: json['email'],
        id: json['_id'],
        isAdmin: iA,
        isSuperAdmin: iSA,
        adminof: adminof,
        superAdminOf: superadminof,
        isSSAdmin: json['superSuperAdmin']);
  }
}

// User currentUser = User('DummyUser', true, [], true, []);
class UClub extends Club {
  // ignore: annotate_overrides
  String clubName;
  // ignore: annotate_overrides
  String id;

  UClub({this.clubName, this.id});

  factory UClub.fromJson(Map<String, dynamic> json) {
    return UClub(
      clubName: json['name'],
      id: json['_id'],
    );
  }
}

class Admin extends User {
  // ignore: annotate_overrides
  String name;
  // ignore: annotate_overrides
  String email;
  // ignore: annotate_overrides
  String id;

  Admin({this.name, this.email, this.id});

  factory Admin.fromJson(Map<String, dynamic> json) {
    String name =
        (json.containsKey('name')) ? json['name'] : "Test ${json["email"]}";
    return Admin(name: name, email: json['email'], id: json['_id']);
  }
}
