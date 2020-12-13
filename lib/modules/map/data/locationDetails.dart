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
  final String short;
  final String subtitle;
  final String details;
  final TimeOfDay openTime;
  final TimeOfDay closeTime;
  final String link;
  final String img;
  final String mapUrl;
  final String contact;

  Location(
      {this.img,
      this.location,
      this.name,
      this.short,
      this.closeTime,
      this.contact,
      this.details,
      this.link,
      this.mapUrl,
      this.openTime,
      this.type,
      this.subtitle});
}
