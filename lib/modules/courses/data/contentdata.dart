// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:html/dom.dart';
// import 'package:html/dom_parsing.dart';
// import 'package:html/parser.dart';

String books = 'books';
String minor1 = 'minor 1';
String minor2 = 'minor 2';
String major = 'major';

var data = {
  'pyl101': {
    books: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book2', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book3', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book4', url: 'https://moodle.iitd.ac.in/')
    ],
    minor1: [
      LinksModel(name: 'book2', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/')
    ],
    minor2: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/')
    ],
    major: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/')
    ]
  },
  'mtl101': {
    books: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book2', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book3', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book4', url: 'https://moodle.iitd.ac.in/')
    ],
    minor1: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/')
    ],
    minor2: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/')
    ],
    major: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/')
    ]
  },
  'col101': {
    books: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book2', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book3', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book4', url: 'https://moodle.iitd.ac.in/')
    ],
    minor1: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/')
    ],
    minor2: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/')
    ],
    major: [
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/'),
      LinksModel(name: 'book1', url: 'https://moodle.iitd.ac.in/')
    ]
  },
};

class LinksModel {
  LinksModel({this.name, this.url});
  String name;
  String url;
}

// class Post extends StatefulWidget {
//   @override
//   _PostState createState() => _PostState();
// }

// class _PostState extends State<Post> {
//   void fetch() async {
//     final response = await http.Client()
//         .get(Uri.parse('https://bsw.iitd.ac.in/questionpaper.php'));
//     if (response.statusCode == 200) {
//       var document = parse(response.body);
//     } else {
//       throw Exception();
//     }
//   }
// }
