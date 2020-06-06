import 'package:IITDAPP/modules/map/data/mapCondition.dart';
import 'package:IITDAPP/modules/map/widgets/marker/currentLocationMarker.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'package:IITDAPP/modules/map/widgets/marker/marker.dart';

class MapOffset extends ChangeNotifier {
  MapOffset(this.mc);

  final MapConditions mc;
  Offset
      tweenPreviousOffset; // offset to store beginning of animation tween when panned
  Offset offset; // offset is where the top left corner of the image is drawn
  Curve animationCurve;
  Size imageSize;
  double scale;
  int panDuration = 0;
  Size canvasSize;
  LatLng NW;
  LatLng SE;

  void moveTo(m) {
    int id;
    if (m.runtimeType == CurrentLocationMarker) {
      id = mc.markers.length;
    } else {
      id = m.id;
    }
    if (Marker.zoomLevel(m.minScale) > scale) {
      mc.onScreenOffset[id] =
          (mc.onScreenOffset[id]) / scale * Marker.zoomLevel(m.minScale);
      offset = offset / scale * Marker.zoomLevel(m.minScale);
      scale = Marker.zoomLevel(m.minScale);
    }
    var o = -mc.onScreenOffset[id] +
        offset +
        Offset(canvasSize.width / 2, canvasSize.height / 2);
    animationCurve = Curves.linear;
    panDuration = 500;
    if (!mc.play[id]) {
      mc.play[id] = true;
    }
    changeOffsets(o);
  }

  void changeOffsets(Offset o) {
    tweenPreviousOffset = offset;
    offset = verifyOffset(o);
    notifyListeners();
  }

  Offset verifyOffset(Offset a) {
    // boundaries not crossed
    var x = -a.dx;
    var y = -a.dy;
    var maxX = imageSize.width * scale - canvasSize.width;
    var maxY = imageSize.height * scale - canvasSize.height;
    x = (x < maxX) ? x : maxX;
    x = x > 0 ? x : 0;
    y = (y < maxY) ? y : maxY;
    y = y > 0 ? y : 0;
    return Offset(-x, -y);
  }

  Offset getOffset(
      //location on screen
      {@required LatLng globalPosition,
      @required Offset tweenOffset}) {
    var yPos = (globalPosition.latitude - NW.latitude) /
            (SE.latitude - NW.latitude) *
            imageSize.height *
            scale +
        tweenOffset.dy;
    var xPos = (-globalPosition.longitude + NW.longitude) /
            (-SE.longitude + NW.longitude) *
            imageSize.width *
            scale +
        tweenOffset.dx;
    return Offset(xPos, yPos);
  }
}
