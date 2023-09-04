bool guest = false;
String token = "";

enum EventsListStatus {
  loading,
  loaded,
  error,
}

enum LostAndFoundListStatus {
  loading,
  loaded,
  error,
}

enum LostandFoundStatus { claimed, unclaimed }

class EndPoints {
  EndPoints._();

  static const String baseURL = 'https://iitdconnect-server.devclub.in';

  //* Events API Endpoints
  static const String fetchEvents = '$baseURL/api/web/events';
  static const String fetchNews = "$baseURL/api/web/news";
  // static const String getAllEvents = '$baseURL/api/events';
  // static const String getStarredEvents = '$baseURL/events/starred';

  //* Lost and Found API Endpoints
  static const String fetchLostAndFound = '$baseURL/api/lostfound';
}
