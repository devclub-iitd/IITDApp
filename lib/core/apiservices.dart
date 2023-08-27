import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iitd_app/models/eventsmodel.dart';
import 'package:iitd_app/utils/constants.dart';

class EventsAPI {
  final client = http.Client();

  Future<List<EventsModel>> fetchAllEvents() async {
    try {
      final response = await client.get(Uri.parse(EndPoints.fetchEvents));
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(data['data']);
      final eventsList = <EventsModel>[];
      if (response.statusCode == 200) {
        for (int i = data['data']['events'].length - 1; i >= 0; i--) {
          eventsList.add(EventsModel.fromJson(data['data']['events'][i]));
        }
        print(eventsList.toString());

        return eventsList;
      } else {
        throw Exception('Some internal error occured');
      }
    } catch (e) {
      throw Exception('Failed to load events');
    }
  }

  Future<EventsModel> fetchEventbyID(String id) async {
    try {
      final response =
          await client.get(Uri.parse('${EndPoints.fetchEvents}?id=$id'));
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return EventsModel.fromJson(data);
      } else {
        throw Exception('Some internal error occured');
      }
    } catch (e) {
      throw Exception('Failed to load event');
    }
  }

  Future<List<EventsModel>> fetchEventsbyBody(String bodyID) async {
    try {
      final response =
          await client.get(Uri.parse('${EndPoints.fetchEvents}?body=$bodyID'));
      final Map<String, dynamic> data = jsonDecode(response.body);
      final eventsList = <EventsModel>[];
      if (response.statusCode == 200) {
        for (int i = data.length - 1; i >= 0; i--) {
          eventsList.add(EventsModel.fromJson(data[i]));
        }
        return eventsList;
      } else {
        throw Exception('Some internal error occured');
      }
    } catch (e) {
      throw Exception('Failed to load events');
    }
  }
}
// class EventsAPI {
//   final client = http.Client();

//   Future<List<EventsModel>> getAllEvents() async {
//     try {
//       final response = await client.get(Uri.parse(EndPoints.getAllEvents));
//       final Map<String, dynamic> data = jsonDecode(response.body);
//       final eventsList = <EventsModel>[];
//       if (response.statusCode == 200) {
//         for (int i = data.length - 1; i >= 0; i++) {
//           eventsList.add(EventsModel.fromJson(data[i]));
//         }
//         return eventsList;
//       } else {
//         throw Exception('Some internal error occured');
//       }
//     } catch (e) {
//       throw Exception('Failed to load events');
//     }
//   }

//   Future<EventsModel> getEventByID(String eventID) async {
//     try {
//       final response =
//           await client.get(Uri.parse('${EndPoints.getAllEvents}/$eventID'));
//       final Map<String, dynamic> data = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         return EventsModel.fromJson(data);
//       } else {
//         throw Exception('Some internal error occured');
//       }
//     } catch (e) {
//       throw Exception('Failed to load event');
//     }
//   }

//   Future<List<EventsModel>> getStarredEvents() async {
//     try {
//       final response = await client.get(Uri.parse(EndPoints.getStarredEvents));
//       final Map<String, dynamic> data = jsonDecode(response.body);
//       final eventsList = <EventsModel>[];
//       if (response.statusCode == 200) {
//         for (int i = data.length - 1; i >= 0; i++) {
//           eventsList.add(EventsModel.fromJson(data[i]));
//         }
//         return eventsList;
//       } else {
//         throw Exception('Some internal error occured');
//       }
//     } catch (e) {
//       throw Exception('Failed to load events');
//     }
//   }
// }
