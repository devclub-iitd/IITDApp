import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/courses/data/coursedata.dart';

class Course {
  String name;
  Color color;
  IconData icondata;
  String slot;
  String department;

  List<String> books;
  List<String> minor1;
  List<String> minor2;
  List<String> major;

  Course({this.name, this.slot}) {
    department = name.substring(0, 2);
    color = alldepartments[department]['color'];
    icondata = alldepartments[department]['icondata'];
  }

  factory Course.fromjson(Map<String, dynamic> json) {
    return Course(
      name: json['name'].toString().toLowerCase(),
      slot: json['slot'].toString(),
    );
  }

  //for v2
  // Course(
  //     {this.name,
  //     this.books,
  //     this.color,
  //     this.department,
  //     this.icon,
  //     this.major,
  //     this.minor1,
  //     this.minor2,
  //     this.slot});
}
