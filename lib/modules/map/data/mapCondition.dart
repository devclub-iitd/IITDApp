import 'package:IITDAPP/modules/map/widgets/marker/currentLocationMarker.dart';
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

  List<Marker> fetchData() {
    print('fetching markers');
    var id = 0;
    markers = [
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'BioTech Lawns',
          subtitle: 'Park',
          location: LatLng(28.545176, 77.193654),
          type: MarkerType.PARK,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
      Marker(
          bgcolor: bgcolor,
          id: id++,
          location: Location(
            name: 'Main Building',
            location: LatLng(28.544635, 77.192082),
            contact: '1234567890',
            link: 'https://google.co.in',
            openTime: TimeOfDay(hour: 1, minute: 1),
            closeTime: TimeOfDay(hour: 23, minute: 23),
          ),
          size: 48),
      Marker(
          bgcolor: bgcolor,
          id: id++,
          location: Location(
            name: 'Lecture Hall Complex',
            location: LatLng(28.543136, 77.193248),
            type: MarkerType.ACADEMIC,
            contact: '1234567890',
            link: 'https://google.co.in',
            openTime: TimeOfDay(hour: 1, minute: 1),
            closeTime: TimeOfDay(hour: 23, minute: 23),
          ),
          size: 48),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Block 6',
          location: LatLng(28.546861, 77.190828),
          type: MarkerType.ACADEMIC,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.HIGH,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Block 5',
          location: LatLng(28.546558, 77.191223),
          type: MarkerType.ACADEMIC,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.HIGH,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Block 4',
          location: LatLng(28.546361, 77.191656),
          type: MarkerType.ACADEMIC,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.HIGH,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Block 3',
          location: LatLng(28.546073, 77.192092),
          type: MarkerType.ACADEMIC,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.HIGH,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Block 2',
          location: LatLng(28.545984, 77.193105),
          type: MarkerType.ACADEMIC,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.HIGH,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Block 1',
          location: LatLng(28.545796, 77.193674),
          type: MarkerType.ACADEMIC,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.HIGH,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Central Workshop',
          location: LatLng(28.543400, 77.192190),
          type: MarkerType.ACADEMIC,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.LOW,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Football Ground',
          location: LatLng(28.544878, 77.187617),
          type: MarkerType.PLAYGROUND,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.LOW,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Hockey Ground',
          location: LatLng(28.543568, 77.190285),
          type: MarkerType.PLAYGROUND,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.LOW,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Cricket Ground',
          location: LatLng(28.544303, 77.188970),
          type: MarkerType.PLAYGROUND,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.LOW,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Cafetaria',
          location: LatLng(28.543429, 77.191293),
          type: MarkerType.FOOD,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.HIGH,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Shivalik Hostel',
          subtitle: 'Hostel',
          location: LatLng(28.547646, 77.185889),
          type: MarkerType.RESIDENCE,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Zanskar Hostel',
          subtitle: 'Hostel',
          location: LatLng(28.546642, 77.186313),
          type: MarkerType.RESIDENCE,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Vindhyanchal Hostel',
          subtitle: 'Hostel',
          location: LatLng(28.548470, 77.186314),
          type: MarkerType.RESIDENCE,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Kumaon Hostel',
          subtitle: 'Hostel',
          location: LatLng(28.549162, 77.185329),
          type: MarkerType.RESIDENCE,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Aravalli Hostel',
          subtitle: 'Hostel',
          location: LatLng(28.548363, 77.183643),
          type: MarkerType.RESIDENCE,
          contact: '123456789',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'NesCafe',
          subtitle: 'Hostel',
          location: LatLng(28.544598, 77.191728),
          type: MarkerType.FOOD,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.HIGH,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Shiru Cafe',
          subtitle: 'Hostel',
          location: LatLng(28.544799, 77.191181),
          type: MarkerType.FOOD,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.HIGH,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'State Bank of India',
          subtitle: 'Hostel',
          location: LatLng(28.543778, 77.193065),
          type: MarkerType.BANK,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'IIT Hospital',
          subtitle: 'Hostel',
          location: LatLng(28.545992, 77.188156),
          type: MarkerType.MEDICAL,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Student Activities Center',
          location: LatLng(28.544900, 77.185382),
          type: MarkerType.PLAYGROUND,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Swimming Pool',
          location: LatLng(28.545839, 77.186101),
          type: MarkerType.PLAYGROUND,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
      Marker(
        bgcolor: bgcolor,
        id: id++,
        location: Location(
          name: 'Masala Mix',
          location: LatLng(28.546227, 77.186645),
          type: MarkerType.FOOD,
          contact: '1234567890',
          link: 'https://google.co.in',
          openTime: TimeOfDay(hour: 1, minute: 1),
          closeTime: TimeOfDay(hour: 23, minute: 23),
        ),
        size: 48,
        minScale: MinScaleLevel.MID,
      ),
    ];
    onScreenOffset = List.filled(markers.length + 1, null);
    play = List.filled(markers.length + 1, false);
    return markers;
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
