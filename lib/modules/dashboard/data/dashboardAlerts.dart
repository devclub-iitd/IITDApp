import 'package:IITDAPP/modules/attendance/data/attendanceModel.dart';
import 'package:IITDAPP/modules/events/events/event_class.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:localstorage/localstorage.dart';
import 'package:IITDAPP/values/colors/Constants.dart';

class DashboardAlerts {
  final ls = LocalStorage('dahsboardAlerts${currentUser.id}');

  DashboardAlerts() {
    // ls.ready.then((value) => ls.clear());
  }

  String getAttendanceKey(AttendanceModel item) {
    return item.abbr.toString() +
        'A' +
        item.daysAbsent.toString() +
        'P' +
        item.daysPresent.toString();
  }

  String getNewsKey(NewsModel item) {
    return item.id.toString() + 'D' + item.createdAt.toString();
  }

  String getEventKey(Event item){
    return item.eventid+item.startsAt.toIso8601String();
  }

  Future<List<int>> getAlerts(List<dynamic> m) async {
    if(m.isEmpty){
      return [];
    }
    var itemname =
        (m[0].runtimeType == AttendanceModel) ? 'attendance' : ((m[0].runtimeType !=Event) ? 'news':'events');
    await ls.ready;
    var newAlerts = <int>[];
    var oldAlerts = (ls.getItem(itemname) ?? []) as List;
    var id =0;
    // print(oldAlerts);
    for (var item in m) {
      var key = (item.runtimeType == AttendanceModel)
          ? getAttendanceKey(item)
          :((item.runtimeType != Event)? getNewsKey(item):getEventKey(item));
      if (!oldAlerts.contains(key)) {
        // print(key);
        newAlerts.add(id);
      }
      id+=1;
    }
    // print('get ${newAlerts}');
    return newAlerts;
  }

  void setPending(String type,List<String> items){
    ls.ready.then((value) => ls.setItem(type, items));
  }

  void setAlerts(List<dynamic> m){
    // print('set call');
    print(m);
    if(m==null || m.isEmpty){
      return;//TODO: delete all alerts ?
    }
    var itemname =
        (m[0].runtimeType == AttendanceModel) ? 'attendance' : ((m[0].runtimeType !=Event) ? 'news':'events');
    var alerts = <String>[];
    for(var item in m){
      alerts.add((item.runtimeType == AttendanceModel)
          ? getAttendanceKey(item)
          :((item.runtimeType != Event)? getNewsKey(item):getEventKey(item)));
    }
    print('set ${alerts}');
    ls.ready.then((value) => ls.setItem(itemname, alerts));
  }
}
