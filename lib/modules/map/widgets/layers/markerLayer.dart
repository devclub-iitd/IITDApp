import 'package:IITDAPP/modules/map/data/mapOffsets.dart';
import 'package:IITDAPP/modules/map/widgets/marker/currentLocationMarker.dart';
import 'package:IITDAPP/modules/map/widgets/marker/markerLabel.dart';
import 'package:IITDAPP/modules/map/widgets/marker/selectedMarker.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import 'package:IITDAPP/modules/map/widgets/marker/marker.dart';
import 'package:IITDAPP/modules/map/widgets/marker/markerIcon.dart';
import 'package:IITDAPP/modules/map/data/mapCondition.dart';

class MarkerLayer extends StatelessWidget {
  const MarkerLayer({
    Key key,
    @required this.visibleMarkers,
    @required this.tweenOffset,
  }) : super(key: key);

  final Iterable<Marker> visibleMarkers;
  final Offset tweenOffset;

  @override
  Widget build(BuildContext context) {
    var mc = Provider.of<MapConditions>(context);
    var mo = Provider.of<MapOffset>(context, listen: false);
    var map = <Widget>[
      ...visibleMarkers.map((m) {
        var x = -m.size / 2;
        var y = -m.size / 2;
        if (mc.selectedMarker == m.id) {
          x = -SelectedMarker.selectedIconSize / 2;
          y = -SelectedMarker.selectedIconSize * 3 / 4;
        }

        final label = MarkerLabel(y: y, label: m.location.name);

        return Positioned(
          left: mc.onScreenOffset[m.id].dx + x,
          top: mc.onScreenOffset[m.id].dy + y,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Transform.scale(
                scale: 0.5,
                child: MarkerIcon(
                  m: m,
                ),
              ),
              label,
            ],
          ),
        );
      }).toList()
    ];

    if (mc.currentLocationCoordinates != LatLng(90, 90)) {
      mc.currentLocationOffset = mo.getOffset(
        globalPosition: mc.currentLocationCoordinates,
        tweenOffset: tweenOffset,
      );
      mc.onScreenOffset.last = mc.currentLocationOffset;
      mc.currentLocationMarker = CurrentLocationMarker();
      map.add(mc.currentLocationMarker);
    }

    return Stack(
      children: map,
    );
  }
}
