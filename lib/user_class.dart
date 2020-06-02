class User {
  String name;
  String email;
  String id;
  bool isAdmin;
  bool isSuperAdmin;
  bool isSSAdmin;

  User({
    this.name,
    this.email,
    this.id,
    this.isAdmin,
    this.isSuperAdmin,
    this.isSSAdmin = false,
  });
}
