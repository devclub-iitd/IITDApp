import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iitd_app/models/eventsmodel.dart';
import 'package:iitd_app/models/newsmodel.dart';
import 'package:iitd_app/utils/constants.dart';

class EventsAPI {
  final client = http.Client();

  Future<List<EventsModel>> fetchAllEvents(String clubID) async {
    String endpoint = EndPoints.fetchEvents;
    if (clubID.isNotEmpty) {
      endpoint += "?body=$clubID";
    }
    try {
      print(endpoint);
      final response = await client.get(Uri.parse(endpoint));
      final Map<String, dynamic> data = jsonDecode(response.body);
      final eventsList = <EventsModel>[];
      if (response.statusCode == 200) {
        for (int i = data['data']['events'].length - 1; i >= 0; i--) {
          eventsList.add(EventsModel.fromJson(data['data']['events'][i]));
        }

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

  // Future<List<EventsModel>> fetchEventsbyBody(String bodyID) async {
  //   try {
  //     final response =
  //         await client.get(Uri.parse('${EndPoints.fetchEvents}?body=$bodyID'));
  //     final Map<String, dynamic> data = jsonDecode(response.body);
  //     final eventsList = <EventsModel>[];
  //     if (response.statusCode == 200) {
  //       for (int i = data.length - 1; i >= 0; i--) {
  //         eventsList.add(EventsModel.fromJson(data[i]));
  //       }
  //       return eventsList;
  //     } else {
  //       throw Exception('Some internal error occured');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load events');
  //   }
  // }
}

class NewsAPI {
  Future<List<NewsModel>> fetchAllNews() async {
    final client = http.Client();
    String endpoint = EndPoints.fetchNews;
    try {
      final response = await client.get(Uri.parse(endpoint));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<NewsModel> list = [];
        for (var i = 0; i < data.length; i++) {
          list.add(NewsModel.fromJson(data[0]));
        }
        print(list.toString());
        return list;
      } else {
        throw Exception("Some internal error occured");
      }
    } catch (e) {
      throw Exception('Failed to load news');
    }
  }
}
