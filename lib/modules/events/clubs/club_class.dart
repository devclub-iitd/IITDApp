class Club {
  String clubName;
  String clubDept;
  String clubAbout;
  bool isSubbed;
  String id;

  Club({this.clubName, this.clubDept, this.clubAbout, this.isSubbed, this.id});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      clubName: json['name'],
      clubAbout: json['about'],
      isSubbed: json['isSub'],
      // clubDept: json["dept"],
      id: json['id']
    );
  }

  Map toMap() {
    var map = <String, dynamic>{};
    map['name'] = clubName;
    map['about'] = clubAbout;
    map['isSub'] = isSubbed.toString();
    map['department'] = clubDept;
    return map;
  }
}

// var dummyClub1 =
//     Club(clubName: 'devclub', clubDept: 'CSE', clubAbout: 'software development club', isSubbed: false, id:"5d6935a5f616bc2d27fa1e72");
// var dummyClub2 =
//     Club(clubName: 'BRCA', clubDept: 'EE', clubAbout: 'software development club', isSubbed: false, id:"5d693590f616bc2d27fa1e71");
// var dummyClub3 =
//     Club(clubName: 'Club3', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: false);
// var dummyClub4 =
//     Club(clubName: 'Club4', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: true);
// var dummyClub5 =
//     Club(clubName: 'Club5', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: false);
// var dummyClub6 =
//     Club(clubName: 'Club6', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: false);
// var dummyClub7 =
//     Club(clubName: 'Club7', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: true);
// var dummyClub8 =
//     Club(clubName: 'Club8', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: false);
// var dummyClub9 =
//     Club(clubName: 'Club9', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: false);
// var dummyClub10 =
//     Club(clubName: 'Club10', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: true);
// var dummyClub11 =
//     Club(clubName: 'Club11', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: false);
// var dummyClub12 =
//     Club(clubName: 'Club12', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: false);
// var dummyClub13 =
//     Club(clubName: 'Club13', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: true);
// var dummyClub14 =
//     Club(clubName: 'Club14', clubDept: 'Dept1', clubAbout: 'wqewdqwe', isSubbed: false);

// List<Club> subbedClubs = [dummyClub4, dummyClub7, dummyClub10, dummyClub13];
// List<Club> otherClubs = [dummyClub1,dummyClub2,dummyClub3,dummyClub5,dummyClub6,dummyClub8,dummyClub9,dummyClub11,dummyClub12,dummyClub14];

// List<List<Club>> dummyClubs = [subbedClubs, otherClubs];
