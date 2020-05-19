List<Map> hostelsList = [
  {
    'name': 'Udaigiri',
    'tagline': 'Eagles',
    'image': 'assets/images/udai_pic.jpeg'
  },
  {
    'name': 'Jwalamukhi',
    'tagline': 'IC',
    'image': 'assets/images/udaigiri_logo.jpg'
  },
  {
    'name': 'Satpura',
    'tagline': 'Samurai',
    'image': 'assets/images/udai_pic.jpeg'
  }
];

Map hostelDetails = {
  'Udaigiri': {
    'about': 'This will be a nice description about the hostel Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit',
    'members': [
      MemberModel(name: 'Pranjal Aggarwal', post: 'House Secretary', image: 'assets/images/udai_pic.jpeg')
    ],
    'image': 'assets/images/udaigiri_logo.jpg'
  },
  'Satpura': {
    'about': 'This will be a nice description about the hostel. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit',
    'members': [
      MemberModel(name: 'Pranjal Aggarwal', post: 'House Secretary', image: 'assets/images/udai_pic.jpeg')
    ],
    'image': 'assets/images/udaigiri_logo.jpg'
  },
  'Jwalamukhi': {
    'about': 'This will be a nice description about the hostel Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit',
    'members': [
      MemberModel(name: 'Pranjal Aggarwal', post: 'House Secretary', image: 'assets/images/udai_pic.jpeg')
    ],
    'image': 'assets/images/udaigiri_logo.jpg'
  },
};

class MemberModel {
  MemberModel({this.name, this.post, this.image,this.fb,this.insta,this.linkedin});
  String name;
  String post;
  String image;
  String fb;
  String insta;
  String linkedin;
}
