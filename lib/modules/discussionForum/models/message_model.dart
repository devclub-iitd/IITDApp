import 'package:IITDAPP/modules/discussionForum/models/user_model.dart';

class Message {
  final User sender;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });
}

// YOU - current user
final User currentUser =
    User(id: 0, name: 'Current User', imageUrl: 'assets/images/devCLogo.png');

// USERS
/*final User devclub = User(id: 1, name: 'Devclub', imageUrl: 'assets/images/greg.jpg');
final User james =
    User(id: 2, name: 'ANCC', imageUrl: 'assets/images/james.jpg');
final User john = User(id: 3, name: 'Rdv', imageUrl: 'assets/images/john.jpg');
final User olivia =
    User(id: 4, name: 'PAC', imageUrl: 'assets/images/olivia.jpg');
final User sam = User(id: 5, name: 'OCS', imageUrl: 'assets/images/sam.jpg');
final User sophia =
    User(id: 6, name: 'Freshers', imageUrl: 'assets/images/sophia.jpg');
final User steven =
    User(id: 7, name: 'MTL Quiz', imageUrl: 'assets/images/steven.jpg');*/
List <User> users=[
  User(
    id: 1,
     name: 'Devclub',
      imageUrl: 'assets/images/devCLogo.png',
      ),
    User(
        id: 2,
         name: 'ANCC',
          imageUrl: 'assets/images/devCLogo.png',//assets/images/james.jpg
          ),
    User(
      id: 3,
       name: 'Rdv',
        imageUrl: 'assets/images/devCLogo.png',
        ),
     User(
       id: 4,
        name: 'PAC',
         imageUrl: 'assets/images/devCLogo.png',
         ),
    User(
      id: 5,
       name: 'OCS',
        imageUrl: 'assets/images/devCLogo.png',
        ),
    User(
      id: 6,
       name: 'Freshers',
        imageUrl: 'assets/images/devCLogo.png',
        ),
    User(
      id: 7,
       name: 'MTL Quiz',
        imageUrl: 'assets/images/devCLogo.png',
        ),

];   

// FAVORITE CONTACTS
List<User> favorites = [users[4], users[3], users[2], users[1], users[0]];//sam, steven, olivia

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: users[0],
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: users[1],
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: users[2],
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: users[3],
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: users[4],
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: users[5],
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: users[6],
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: users[0],
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: users[1],
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: users[2],
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: users[3],
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];