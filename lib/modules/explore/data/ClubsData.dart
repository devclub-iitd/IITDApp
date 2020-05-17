
List<Map> clubsList = [
  {'name': 'Dev Club', 'motto': 'We Code Things'},
  {'name': 'Dev Club', 'motto': 'We Build Things'},
  {'name': 'Dev Club', 'motto': 'We are Coders'},
  {'name': 'Dev Club', 'motto': 'We Code Things'},
  {'name': 'Dev Club', 'motto': 'We Build Things'},
  {'name': 'Dev Club', 'motto': 'We are Coders'},
  {'name': 'Dev Club', 'motto': 'We Code Things'},
  {'name': 'Dev Club', 'motto': 'We Build Things'},
  {'name': 'Dev Club', 'motto': 'We are Coders'},
  {'name': 'Dev Club', 'motto': 'We Code Things'},
  {'name': 'Dev Club', 'motto': 'We Build Things'},
  {'name': 'Dev Club', 'motto': 'We are Coders'},
];

Map clubsDetails = {
  'Dev Club': {
    'about': 'This will be a nice description about the club Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit',
    'events': [
      EventsModel(title: 'Introduction to Blockchain', note: 'Starts in 2 days',
          image: 'assets/images/devCLogo.png'),
    ],
    'members': [
      MemberModel(name: 'Shourya Aggarwal', post: 'Overall Coordinator', image: 'assets/images/devCLogo.png')
    ],
    'image': 'assets/images/devCCover.png'
  }
};

class EventsModel {
  EventsModel({this.title, this.note, this.image});
  String title;
  String note;
  String image;
}

class MemberModel {
  MemberModel({this.name, this.post, this.image});
  String name;
  String post;
  String image;
}
