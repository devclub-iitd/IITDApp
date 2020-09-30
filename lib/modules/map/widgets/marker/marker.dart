import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/map/data/locationDetails.dart';
import 'package:latlong/latlong.dart';

enum MinScaleLevel { HIGH, MID, LOW }

class Marker extends StatelessWidget {
  final Location location;
  final int id;
  final double size;
  final MinScaleLevel minScale;
  final List<Color> bgcolor;
  Marker(
      {@required this.location,
      @required this.id,
      @required this.size,
      this.minScale,
      @required this.bgcolor}) {
    bgcolor.add(getbgcolor(location.type));
  }

  @override
  Widget build(BuildContext context) {
    return getIcon(location.type, size: size / 2);
  }

  static double zoomLevel(MinScaleLevel l) {
    switch (l) {
      case MinScaleLevel.HIGH:
        return 0.7;
      case MinScaleLevel.MID:
        return 0.5;
      case MinScaleLevel.LOW:
        return 0.3;
      default:
        return 0;
    }
  }

  factory Marker.fromJson(
      Map<String, dynamic> json, int id, List<Color> bgcolor) {
    return Marker(
      location: Location(
          contact: json['contact'].toString(),
          details: json['details'],
          link: json['link'],
          name: json['name'],
          subtitle: json['subtitle'],
          type: json['type'] < 10 ? MarkerType.values[json['type']] : null,
          location: LatLng(
              json['latitude'], json['longitude']),
          closeTime: TimeOfDay(
              hour: int.parse(json['closetime'].substring(0, 2)),
              minute: int.parse(json['closetime'].substring(2, 4))),
          openTime: TimeOfDay(
              hour: int.parse(json['opentime'].substring(0, 2)),
              minute: int.parse(json['opentime'].substring(2, 4)))),
      id: id,
      size: 48,
      bgcolor: bgcolor,
      minScale: json['minscale'] != 0
          ? MinScaleLevel.values[3-json['minscale']]
          : null,
    );
  }

  Color getbgcolor(m) {
    switch (m) {
      case MarkerType.ACADEMIC:
        return Colors.yellow;
        break;
      case MarkerType.MEDICAL:
        return Colors.red;
        break;
      case MarkerType.GATE:
        return Colors.green;
        break;
      default:
        return Colors.blue;
        break;
    }
  }

  static Icon getIcon(m, {size}) {
    IconData i;
    Color fc;
    switch (m) {
      case MarkerType.ACADEMIC:
        i = Icons.book;
        break;
      case MarkerType.BANK:
        i = Icons.local_atm;
        break;
      case MarkerType.FOOD:
        i = Icons.local_dining;
        break;
      case MarkerType.GATE:
        i = Icons.local_play;
        break;
      case MarkerType.MEDICAL:
        i = Icons.local_hospital;
        break;
      case MarkerType.PARK:
        i = Icons.local_florist;
        break;
      case MarkerType.PLAYGROUND:
        i = Icons.local_play;
        break;
      case MarkerType.RESIDENCE:
        i = Icons.local_hotel;
        break;
      case MarkerType.SHOP:
        i = Icons.local_grocery_store;
        break;
      case MarkerType.THEATRE:
        i = Icons.local_movies;
        break;
      default:
        i = Icons.location_city;
        break;
    }
    switch (m) {
      case MarkerType.ACADEMIC:
        fc = Colors.black;
        break;
      default:
        fc = Colors.white;
        break;
    }
    return Icon(
      i,
      color: fc,
      size: size,
    );
  }
}
