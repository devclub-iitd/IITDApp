import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class AttendanceModel {
  int daysPresent, daysAbsent;
  List<DateTime> presentDates;
  String name, abbr;
  AttendanceModel(
      {this.name,
      this.abbr,
      this.daysPresent,
      this.daysAbsent,
      this.presentDates});

  factory AttendanceModel.fromJSON(Map<String, dynamic> course) {
    return AttendanceModel(
      name: course['name'],
      abbr: course['abbr'],
      daysPresent: course['daysPresent'],
      daysAbsent: course['daysAbsent'],
      presentDates: <DateTime>[
        ...(course['presentDays']
            .map((f) => DateFormat('dd/MM/yyyy').parse(f))
            .toList())
      ],
    );
  }

  static Future<List<AttendanceModel>> getAttendanceData(String entryNumber) async {
    var data =
        await http.get('http://www.mocky.io/v2/5ebc43f43100004a005b0a9b');
    if (data.statusCode != 200) {
      throw Exception('Failed to fetch data');
    } else {
      var jsondata = json.decode(data.body);
      var attendances = <AttendanceModel>[];
      for (var courseJSON in jsondata) {
        var course = AttendanceModel.fromJSON(courseJSON);
        attendances.add(course);
      }
      // print('fetched ' + attendances.length.toString());
      return attendances;
    }
  }
}
