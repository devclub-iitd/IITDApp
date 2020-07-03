import 'package:IITDAPP/modules/map/widgets/marker/currentLocationMarker.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/map/widgets/marker/marker.dart';
import 'package:IITDAPP/modules/map/data/locationDetails.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart' as location_pack;

class MapConditions with ChangeNotifier {
  MapConditions() {
    typeIndex = MarkerType.values;
    typesVisible = List.filled(MarkerType.values.length, true);
  }
  int selectedMarker = -1;
  List<Marker> markers;
  List<Offset> onScreenOffset;
  List<bool> play;
  List<Color> bgcolor = [];

  List typeIndex;
  List<bool> typesVisible; //types of markers visible
  bool toggled = false;

  Offset currentLocationOffset;
  LatLng currentLocationCoordinates = LatLng(90, 90);
  CurrentLocationMarker currentLocationMarker;
  bool currentLocationVisible =
      false; //slideUpSheet not to be displayed when true
  bool searchTapped =
      false; //ensure on time animating of current location marker

  void setCurrentLocation(LatLng c) {
    currentLocationCoordinates = c;
    notifyListeners();
  }

  bool isVisible(MarkerType t) {
    var ti = typeIndex.indexOf(t);
    if (ti == -1) {
      return true;
    }
    return typesVisible[ti];
  }

  Future<List<Marker>> fetchData() async {
    print('fetching markers');
    var id = 0;
    markers = <Marker>[
      ...(await apiBaseHelper.get(
              'https://run.mocky.io/v3/fcdea4e4-65c3-41f1-8578-42ecaf13a8e7'))
          .map((e) => Marker.fromJson(e, id++, bgcolor))
          .toList()
    ];

    //   http.post(
    //   'http://192.168.43.81:8080/',
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(markers.map((e) => e.toJson()).toList()),
    // ).then((value) => print(value.body));
    onScreenOffset = List.filled(markers.length + 1, null);
    play = List.filled(markers.length + 1, false);
    return markers;
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  void markerSelected(int i) {
    selectedMarker = i;
    print('selected $i');
    notifyListeners();
  }

  void toggleType(int type) {
    typesVisible[type] = !typesVisible[type];
    toggled = true;
    notifyListeners();
  }

  Future<void> searchLocation() async {
    var location = location_pack.Location();
    bool _serviceEnabled;
    location_pack.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == location_pack.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != location_pack.PermissionStatus.granted) {
        return;
      }
    }

    return location.getLocation().then((value) {
      searchTapped = true;
      currentLocationVisible = true;
      currentLocationCoordinates = LatLng(value.latitude, value.longitude);
      print(currentLocationCoordinates);
      notifyListeners();
    });
  }

  void removeCurrentLocation() {
    currentLocationVisible = false;
    currentLocationCoordinates = LatLng(90, 90);
    currentLocationMarker = null;
    notifyListeners();
  }
}
