class EndPoints {
  EndPoints._();

  static const String baseURL = 'https://iitdconnect-server.devclub.in';

  //* Events API Endpoints
  static const String getAllEvents = '$baseURL/api/events';
  static const String getStarredEvents = '$baseURL/events/starred';
}

bool guest = false;
String token = "";
