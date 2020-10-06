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
            .map((f) =>
                DateFormat('dd/MM/yyyy').parse(f).add(Duration(days: 220)))
            .toList())
      ],
    );
  }
}
