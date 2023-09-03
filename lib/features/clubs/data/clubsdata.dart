class ClubCardModel {
  final String? name;
  final String? motto;
  final String? image;
  final String? id;

  ClubCardModel({
    required this.name,
    required this.motto,
    required this.image,
    required this.id,
  });

  factory ClubCardModel.fromJson(Map<String, dynamic> json) {
    return ClubCardModel(
      name: json['name'],
      motto: json['motto'],
      image: json['image'],
      id: json['_id'],
    );
  }
}

List<Map<String, dynamic>> clubsListJSONdata = [
  // {
  //   'name': 'AcesACM',
  //   'motto': 'Computer Science department society of IITD',
  //   'image': 'assets/images/aces.jpeg',
  //   '_id': "",
  // },
  {
    'name': 'Aeromodelling Club',
    'motto': '',
    'image': 'assets/images/aero.png',
    "_id": "61d142e6576efe9e64e31d02",
  },
  {
    'name': 'Algorithms & Coding Club',
    'motto': 'ANCC',
    'image': 'assets/images/ancc.jpeg',
    "_id": "61c8a5e9424148c95c0a72aa",
  },
  {
    'name': 'Ankahi',
    'motto': 'Dramatics Society of IITD',
    'image': 'assets/images/ankahi.jpeg',
    "_id": "61c98a82bacad2dbde00dd5d",
  },
  {
    'name': 'AXLR8R',
    'motto': '',
    'image': 'assets/images/axlr8r.jpeg',
    "_id": "61d14309b4f4cb10862ce516",
  },
  {
    'name': 'Board of Sports Activities',
    'motto': 'BSA IIT Delhi',
    'image': 'assets/images/bsa.jpeg',
    "_id": "61d1a06a128349f8d68ecfc3",
  },
  {
    'name': 'Board of Student Publications',
    'motto': 'BSP IITD',
    'image': 'assets/images/bsp.jpeg',
    "_id": "61d1a04362fe692164b0b078",
  },
  {
    'name': 'Debating Club',
    'motto': 'DebSoc IITD',
    'image': 'assets/images/deb.jpeg',
    "_id": "61d1a18aeba8731992ca0fa1",
  },
  {
    'name': 'Design Club',
    'motto': 'Everything is designed, some things are designed well',
    'image': 'assets/images/design.jpeg',
    "_id": "61d1a098128349f8d68ecfeb",
  },
  {
    'name': 'DevClub',
    'motto': 'A Community of tech-minded people in IIT Delhi',
    'image': 'assets/images/devCLogo.png',
    "_id": "61a4b7184784f56e6e9876cf",
  },
  {
    'name': 'Economics Club',
    'motto': '',
    'image': 'assets/images/eco.jpeg',
    "_id": "61d142ae128349f8d68ec4ee",
  },
  // {
  //   'name': 'Electrical Engineering Society',
  //   'motto': 'EES IITD',
  //   'image': 'assets/images/EES.png',
  //   '_id': "",
  // },
  // {
  //   'name': 'Enactus IIT Delhi',
  //   'motto': '',
  //   'image': 'assets/images/enactus.jpeg',
  //   '_id': "",
  // },
  {
    'name': 'Azure : Fine Arts Society',
    'motto': 'FACC IIT Delhi',
    'image': 'assets/images/facc.jpeg',
    "_id": "61c77c92ab949055eadfd266",
  },
  {
    'name': 'Finance Club',
    'motto': '',
    'image': 'assets/images/fin.png',
    "_id": "61d19fe4576efe9e64e32800",
  },
  // {
  //   'name': 'Indoor Sports Club',
  //   'motto': '',
  //   'image': 'assets/images/isc.png',
  //   '_id': "",
  // },
  // {
  //   'name': 'Indradhanu',
  //   'motto': '',
  //   'image': 'assets/images/ankahi.jpeg',
  //   '_id': "",
  // },
  {
    'name': 'LitCLub',
    'motto': '',
    'image': 'assets/images/lit.jpeg',
    "_id": "61cee77cfed76e134712a6eb",
  },
  // {
  //   'name': 'Mathematics Society',
  //   'motto': '',
  //   'image': 'assets/images/mathsoc.jpeg',
  //   '_id': "",
  // },
  {
    'name': 'Photography & Films Club',
    'motto': 'PFC IITD',
    'image': 'assets/images/pfc.jpeg',
    "_id": "61d81cda37b4ea135c5f85a8",
  },
  {
    'name': 'Quizzing Club',
    'motto': '',
    'image': 'assets/images/qc.jpeg',
    "_id": "61d19f35b4f4cb10862cefac",
  },
  {
    'name': 'Robotics Club',
    'motto': '',
    'image': 'assets/images/robo.jpeg',
    "_id": "61d14232eba8731992ca03c9",
  },
  {
    'name': 'ShARE',
    'motto': '',
    'image': 'assets/images/shARE.jpeg',
    "_id": "61d19f11b4f4cb10862cef96",
  },
  // {
  //   'name': 'Student Mentorship Program',
  //   'motto': 'SMP IITD',
  //   'image': 'assets/images/ankahi.jpeg',
  //   '_id': "",
  // },
  {
    'name': 'Wellness Club',
    'motto': '',
    'image': 'assets/images/wellness.png',
    "_id": "61d19ee362fe692164b0af9a",
  },
  {
    'name': 'Dance Club',
    'motto': '',
    'image': 'assets/images/dance.jpeg',
    "_id": "61cd58042f001f09dcca265b",
  },
  {
    'name': 'edC',
    'motto': '',
    'image': 'assets/images/edC.jpeg',
    "_id": "61d19d3d128349f8d68ecd90",
  },
  {
    'name': 'Hindi Samiti',
    'motto': '',
    'image': 'assets/images/hs.jpeg',
    "_id": "61cee74dd56f4b184eb5561c",
  },
  {
    'name': 'Music Club (Cadence)',
    'motto': '',
    'image': 'assets/images/music.jpeg',
    "_id": "61c9b86511fd471de875f342",
  },
  {
    'name': 'SPIC MACAY',
    'motto': '',
    'image': 'assets/images/spic.jpeg',
    "_id": "61cee7594e8aec276122fd8e",
  },
  // {
  //   'name': 'IITD OnAir',
  //   'motto': '',
  //   'image': 'assets/images/onair.jpeg',
  //   '_id': "",
  // },
  // {
  //   'name': 'V-Defyn',
  //   'motto': '',
  //   'image': 'assets/images/v-defyn.jpeg',
  //   '_id': "",
  // },
  {
    'name': 'Physics and Astronomy Club',
    'motto': '',
    'image': 'assets/images/pac.jpeg',
    "_id": "61d1433694bdea792974565e",
  },
  {
    'name': 'NSS',
    'motto': 'Empowering Change for a Better Nation!',
    'image': 'assets/images/nss.jpeg',
    "_id": "61d81d745438f2c0949ccaf8",
  },
];
