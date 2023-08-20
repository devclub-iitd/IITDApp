class LostandFoundModel {
  String id;
  String title;
  DateTime timestamp;
  String img;
  String wherefound;
  LostandFoundStatus status;
  String? desc;

  LostandFoundModel(
      {required this.id,
      required this.title,
      required this.timestamp,
      required this.img,
      required this.status,
      required this.wherefound,
      this.desc});
}

enum LostandFoundStatus { listed, claimed, returned }
