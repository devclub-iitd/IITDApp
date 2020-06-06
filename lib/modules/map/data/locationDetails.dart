import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

enum MarkerType {
  RESIDENCE,
  ACADEMIC,
  FOOD,
  PARK,
  MEDICAL,
  THEATRE,
  PLAYGROUND,
  SHOP,
  BANK,
  GATE,
}

class Location {
  final LatLng location;
  final MarkerType type;
  final String name;
  final String subtitle;
  final String details;
  final TimeOfDay openTime;
  final TimeOfDay closeTime;
  final String link;
  final String contact;

  Location(
      {this.location,
      this.name,
      this.closeTime,
      this.contact,
      this.details,
      this.link,
      this.openTime,
      this.type,
      this.subtitle});
}
