import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/map/data/locationDetails.dart';
import 'package:latlong/latlong.dart';

enum MinScaleLevel { LOW, MID, HIGH }

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
        return 0.8;
      case MinScaleLevel.MID:
        return 0.4;
      case MinScaleLevel.LOW:
        return 0;
      default:
        return 0;
    }
  }

  factory Marker.fromJson(
      Map<String, dynamic> json, int id, List<Color> bgcolor) {
    return Marker(
        location: Location(
          contact: json['phoneUrl'].toString(),
          details: json['details'],
          img: json['img'],
          link: json['webUrl'],
          location: LatLng(json['cd'][0], json['cd'][1]),
          mapUrl: json['mapUrl'],
          name: json['name'],
          short: json['short'] ?? json['name'],
          subtitle: json['category'],
          type: getType(json['category']),
          // closeTime: TimeOfDay(
          //     hour: int.parse(json['closetime'].substring(0, 2)),
          //     minute: int.parse(json['closetime'].substring(2, 4))),
          // openTime: TimeOfDay(
          //     hour: int.parse(json['opentime'].substring(0, 2)),
          //     minute: int.parse(json['opentime'].substring(2, 4)))
        ),
        id: id,
        size: 48,
        bgcolor: bgcolor,
        minScale: MinScaleLevel.values[json['minScale']]);
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

MarkerType getType(String category) {
  switch (category) {
    case 'academic':
      return MarkerType.ACADEMIC;
    case 'bank':
      return MarkerType.BANK;
    case 'hostel':
      return MarkerType.RESIDENCE;
    case 'entertainment':
      return MarkerType.THEATRE;
    case 'eat':
      return MarkerType.FOOD;
    case 'medical':
      return MarkerType.MEDICAL;
    case 'park':
      return MarkerType.PARK;
    case 'sport':
      return MarkerType.PLAYGROUND;
    case 'shop':
      return MarkerType.SHOP;
    default:
      return null;
  }
}
