class ClubCardModel {
  final String? name;
  final String? motto;
  final String? image;

  ClubCardModel({
    required this.name,
    required this.motto,
    required this.image,
  });

  factory ClubCardModel.fromJson(Map<String, dynamic> json) {
    return ClubCardModel(
      name: json['name'],
      motto: json['motto'],
      image: json['image'],
    );
  }
}

List<Map<String, dynamic>> clubsListJSONdata = [
  {
    'name': 'AcesACM',
    'motto': 'Computer Science department society of IITD',
    'image': 'assets/images/aces.jpeg'
  },
  {
    'name': 'Aeromodelling Club',
    'motto': '',
    'image': 'assets/images/aero.png'
  },
  {
    'name': 'Algorithms & Coding Club',
    'motto': 'ANCC',
    'image': 'assets/images/ancc.jpeg'
  },
  {
    'name': 'Ankahi',
    'motto': 'Dramatics Society of IITD',
    'image': 'assets/images/ankahi.jpeg'
  },
  {'name': 'AXLR8R', 'motto': '', 'image': 'assets/images/axlr8r.jpeg'},
  {
    'name': 'Board of Sports Activities',
    'motto': 'BSA IIT Delhi',
    'image': 'assets/images/bsa.jpeg'
  },
  {
    'name': 'Board of Student Publications',
    'motto': 'BSP IITD',
    'image': 'assets/images/bsp.jpeg'
  },
  {
    'name': 'Debating Club',
    'motto': 'DebSoc IITD',
    'image': 'assets/images/deb.jpeg'
  },
  {
    'name': 'Design Club',
    'motto': 'Everything is designed, some things are designed well',
    'image': 'assets/images/design.jpeg'
  },
  {
    'name': 'DevClub',
    'motto': 'A Community of tech-minded people in IIT Delhi',
    'image': 'assets/images/devCLogo.png'
  },
  {'name': 'Economics Club', 'motto': '', 'image': 'assets/images/eco.jpeg'},
  {
    'name': 'Electrical Engineering Society',
    'motto': 'EES IITD',
    'image': 'assets/images/EES.png'
  },
  {
    'name': 'Enactus IIT Delhi',
    'motto': '',
    'image': 'assets/images/enactus.jpeg'
  },
  {
    'name': 'Azure : Fine Arts Society',
    'motto': 'FAC IIT Delhi',
    'image': 'assets/images/facc.jpeg'
  },
  {'name': 'Finance Club', 'motto': '', 'image': 'assets/images/fin.png'},
  {'name': 'Indoor Sports Club', 'motto': '', 'image': 'assets/images/isc.png'},
  {'name': 'Indradhanu', 'motto': '', 'image': 'assets/images/ankahi.jpeg'},
  {'name': 'LitCLub', 'motto': '', 'image': 'assets/images/lit.jpeg'},
  {
    'name': 'Mathematics Society',
    'motto': '',
    'image': 'assets/images/mathsoc.jpeg'
  },
  {
    'name': 'Photography & Films Club',
    'motto': 'PFC IITD',
    'image': 'assets/images/pfc.jpeg'
  },
  {'name': 'Quizzing Club', 'motto': '', 'image': 'assets/images/qc.jpeg'},
  {'name': 'Robotics Club', 'motto': '', 'image': 'assets/images/robo.jpeg'},
  {'name': 'ShARE', 'motto': '', 'image': 'assets/images/shARE.jpeg'},
  {
    'name': 'Student Mentorship Program',
    'motto': 'SMP IITD',
    'image': 'assets/images/ankahi.jpeg'
  },
  {'name': 'Wellness Club', 'motto': '', 'image': 'assets/images/wellness.png'},
  {'name': 'Dance Club', 'motto': '', 'image': 'assets/images/dance.jpeg'},
  {'name': 'edC', 'motto': '', 'image': 'assets/images/edC.jpeg'},
  {'name': 'Hindi Samiti', 'motto': '', 'image': 'assets/images/hs.jpeg'},
  {
    'name': 'Music Club (Cadence)',
    'motto': '',
    'image': 'assets/images/music.jpeg'
  },
  {'name': 'SPIC MACAY', 'motto': '', 'image': 'assets/images/spic.jpeg'},
  {'name': 'IITD OnAir', 'motto': '', 'image': 'assets/images/onair.jpeg'},
  {'name': 'V-Defyn', 'motto': '', 'image': 'assets/images/v-defyn.jpeg'},
  {
    'name': 'Physics and Astronomy Club',
    'motto': '',
    'image': 'assets/images/pac.jpeg'
  },
];
