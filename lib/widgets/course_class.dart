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

  Course(this.name) {
    department = name.substring(0, 2);
    slot = js[name.toUpperCase()];
    color = alldepartments[department]['color'];
    icondata = alldepartments[department]['icondata'];
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
