import 'package:iitd_app/models/clubmodel.dart';
import 'package:iitd_app/models/eventsmodel.dart';
import 'package:iitd_app/models/lostandfoundmodel.dart';

List<EventsModel> dummyeventsList() {
  List<EventsModel> list = [
    EventsModel(
      eventid: '1',
      eventName: 'Event 1',
      eventBody: Club(
        clubName: 'Club A',
        clubAbout: 'About Club A',
        id: 'club1',
      ),
      venue: 'Venue 1',
      startsAt: DateTime(2023, 8, 20, 10, 0),
      endsAt: DateTime(2023, 8, 20, 12, 0),
      about:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
      imageLink:
          'https://images.unsplash.com/photo-1692229218960-8ed454bead96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      isStarred: false,
      isSub: true,
    ),
    EventsModel(
      eventid: '2',
      eventName: 'Event 2',
      eventBody: Club(
        clubName: 'Club B',
        clubAbout: 'About Club B',
        id: 'club2',
      ),
      venue: 'Venue 2',
      startsAt: DateTime(2023, 8, 21, 14, 0),
      endsAt: DateTime(2023, 8, 21, 16, 0),
      about:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
      imageLink:
          'https://images.unsplash.com/photo-1682686581484-a220483e6291?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      isStarred: true,
      isSub: false,
    ),
    EventsModel(
      eventid: '3',
      eventName: 'Event 3',
      eventBody: Club(
        clubName: 'Club C',
        clubAbout: 'About Club C',
        id: 'club3',
      ),
      venue: 'Venue 3',
      startsAt: DateTime(2023, 8, 22, 9, 0),
      endsAt: DateTime(2023, 8, 22, 11, 0),
      about:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
      imageLink:
          'https://images.unsplash.com/photo-1682686581484-a220483e6291?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      isStarred: false,
      isSub: true,
    ),
    EventsModel(
      eventid: '4',
      eventName: 'Event 4',
      eventBody: Club(
        clubName: 'Club D',
        clubAbout: 'About Club D',
        id: 'club4',
      ),
      venue: 'Venue 4',
      startsAt: DateTime(2023, 8, 23, 13, 0),
      endsAt: DateTime(2023, 8, 23, 15, 0),
      about:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
      imageLink:
          'https://images.unsplash.com/photo-1692273881354-52bbf11bacad?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      isStarred: true,
      isSub: false,
    ),
    EventsModel(
      eventid: '5',
      eventName: 'Event 5',
      eventBody: Club(
        clubName: 'Club E',
        clubAbout: 'About Club E',
        id: 'club5',
      ),
      venue: 'Venue 5',
      startsAt: DateTime(2023, 8, 24, 10, 0),
      endsAt: DateTime(2023, 8, 24, 12, 0),
      about:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
      imageLink:
          'https://images.unsplash.com/photo-1692229218960-8ed454bead96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      isStarred: false,
      isSub: true,
    ),
    EventsModel(
      eventid: '6',
      eventName: 'Event 6',
      eventBody: Club(
        clubName: 'Club F',
        clubAbout: 'About Club F',
        id: 'club6',
      ),
      venue: 'Venue 6',
      startsAt: DateTime(2023, 8, 25, 14, 0),
      endsAt: DateTime(2023, 8, 25, 16, 0),
      about:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
      imageLink:
          'https://images.unsplash.com/photo-1682686581484-a220483e6291?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      isStarred: true,
      isSub: false,
    ),
    EventsModel(
      eventid: '7',
      eventName: 'Event 7',
      eventBody: Club(
        clubName: 'Club G',
        clubAbout: 'About Club G',
        id: 'club7',
      ),
      venue: 'Venue 7',
      startsAt: DateTime(2023, 8, 26, 9, 0),
      endsAt: DateTime(2023, 8, 26, 11, 0),
      about:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
      imageLink:
          'https://images.unsplash.com/photo-1692229218960-8ed454bead96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      isStarred: false,
      isSub: true,
    ),
    EventsModel(
      eventid: '8',
      eventName: 'Event 8',
      eventBody: Club(
        clubName: 'Club H',
        clubAbout: 'About Club H',
        id: 'club8',
      ),
      venue: 'Venue 8',
      startsAt: DateTime(2023, 8, 27, 13, 0),
      endsAt: DateTime(2023, 8, 27, 15, 0),
      about:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
      imageLink:
          'https://images.unsplash.com/photo-1692273881354-52bbf11bacad?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      isStarred: true,
      isSub: false,
    ),
    EventsModel(
      eventid: '9',
      eventName: 'Event 9',
      eventBody: Club(
        clubName: 'Club I',
        clubAbout: 'About Club I',
        id: 'club9',
      ),
      venue: 'Venue 9',
      startsAt: DateTime(2023, 8, 28, 10, 0),
      endsAt: DateTime(2023, 8, 28, 12, 0),
      about:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
      imageLink:
          'https://images.unsplash.com/photo-1692273881354-52bbf11bacad?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      isStarred: false,
      isSub: true,
    ),
    EventsModel(
      eventid: '10',
      eventName: 'Event 10',
      eventBody: Club(
        clubName: 'Club J',
        clubAbout: 'About Club J',
        id: 'club10',
      ),
      venue: 'Venue 10',
      startsAt: DateTime(2023, 8, 29, 14, 0),
      endsAt: DateTime(2023, 8, 29, 16, 0),
      about:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
      imageLink:
          'https://images.unsplash.com/photo-1692229218960-8ed454bead96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      isStarred: true,
      isSub: false,
    ),
  ];

  list.shuffle();
  return list;
}

List<LostandFoundModel> lostandfoundlist() {
  List<LostandFoundModel> list = [
    LostandFoundModel(
      id: 'LF001',
      title: 'Lost Wallet',
      timestamp: DateTime(2023, 8, 10),
      img: 'wallet.jpg',
      wherefound: 'Park Bench',
      status: LostandFoundStatus.listed,
      desc: 'Black leather wallet with ID and credit cards.',
    ),
    LostandFoundModel(
      id: 'LF002',
      title: 'Found Smartphone',
      timestamp: DateTime(2023, 8, 12),
      img: 'phone.jpg',
      wherefound: 'Coffee Shop',
      status: LostandFoundStatus.listed,
      desc: 'Apple iPhone 12 found with a cracked screen.',
    ),
    LostandFoundModel(
      id: 'LF003',
      title: 'Lost Keys',
      timestamp: DateTime(2023, 8, 15),
      img: 'keys.jpg',
      wherefound: 'Bus Stop',
      status: LostandFoundStatus.listed,
      desc: 'Set of house and car keys with a keychain.',
    ),
    LostandFoundModel(
      id: 'LF004',
      title: 'Lost Backpack',
      timestamp: DateTime(2023, 8, 17),
      img: 'backpack.jpg',
      wherefound: 'Library',
      status: LostandFoundStatus.claimed,
      desc: 'Blue backpack with a laptop inside.',
    ),
    LostandFoundModel(
      id: 'LF005',
      title: 'Found Watch',
      timestamp: DateTime(2023, 8, 19),
      img: 'watch.jpg',
      wherefound: 'Gym Locker',
      status: LostandFoundStatus.listed,
      desc: "Men's wristwatch, brand unknown.",
    ),
    LostandFoundModel(
      id: 'LF006',
      title: 'Lost Glasses',
      timestamp: DateTime(2023, 8, 20),
      img: 'glasses.jpg',
      wherefound: 'Restaurant',
      status: LostandFoundStatus.listed,
      desc: 'Prescription eyeglasses in a black case.',
    ),
    LostandFoundModel(
      id: 'LF007',
      title: 'Lost Pet Dog',
      timestamp: DateTime(2023, 8, 21),
      img: 'dog.jpg',
      wherefound: 'Park',
      status: LostandFoundStatus.listed,
      desc: 'Small brown dog with a collar.',
    ),
    LostandFoundModel(
      id: 'LF008',
      title: 'Lost Earring',
      timestamp: DateTime(2023, 8, 22),
      img: 'earring.jpg',
      wherefound: 'Movie Theater',
      status: LostandFoundStatus.returned,
      desc: 'Silver hoop earring with a blue gem.',
    ),
    LostandFoundModel(
      id: 'LF009',
      title: 'Found Bicycle',
      timestamp: DateTime(2023, 8, 23),
      img: 'bike.jpg',
      wherefound: 'Street Corner',
      status: LostandFoundStatus.listed,
      desc: 'Red mountain bike with a flat tire.',
    ),
    LostandFoundModel(
      id: 'LF010',
      title: 'Lost Passport',
      timestamp: DateTime(2023, 8, 25),
      img: 'passport.jpg',
      wherefound: 'Airport',
      status: LostandFoundStatus.claimed,
      desc: 'US passport belonging to John Doe.',
    ),
  ];

  list.shuffle();
  return list;
}
