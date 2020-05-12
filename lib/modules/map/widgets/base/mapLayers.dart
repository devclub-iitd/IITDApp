import 'package:IITDAPP/modules/map/data/slidePanelPosition.dart';
import 'package:IITDAPP/values/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import 'package:IITDAPP/modules/map/data/mapCondition.dart';
import 'package:IITDAPP/modules/map/data/mapOffsets.dart';
import 'package:IITDAPP/modules/map/widgets/layers/mapLayer.dart';
import 'package:IITDAPP/modules/map/widgets/layers/slideUpSheet/slideUpSheet.dart';
import 'package:IITDAPP/modules/map/widgets/layers/toggleGrid/toggleGrid.dart';
import 'package:IITDAPP/modules/map/widgets/animatedButton.dart';

class MapLayers extends StatefulWidget {
  const MapLayers({
    Key key,
  }) : super(key: key);

  @override
  _MapLayersState createState() => _MapLayersState();
}

class _MapLayersState extends State<MapLayers> with TickerProviderStateMixin {
  final NW = LatLng(28.551780, 77.177935);
  final SE = LatLng(28.537345, 77.201837);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  final MapImage = AssetImage('assets/images/map-image.png');
  MapOffset mo;
  MapConditions mc;

  @override
  void initState() {
    mo = Provider.of<MapOffset>(context, listen: false);
    mc = Provider.of<MapConditions>(context, listen: false);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this, value: 0);
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    mo.NW = NW;
    mo.SE = SE;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('built layers');
    return Stack(children: [
      Container(
        color: AppColors.MAP_BACKGROUND_COLOR,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: MapLayer(
          MapImage,
          NW: NW,
          SE: SE,
          markers: mc.fetchData(),
        ),
      ),
      Positioned(
          top: 10, right: 10, child: FilterButton(controller: _controller)),
      Consumer<SlidePanelPosition>(
        builder: (_, spp, child) => Positioned(
          bottom: spp.position + 10,
          right: 10,
          child: child,
        ),
        child: LocationButton(mc: mc, mo: mo),
      ),
      Positioned(
          top: 20,
          right: 80,
          child: ToggleGrid(scaleAnimation: _scaleAnimation)),
      SlideUpSheet()
    ]);
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key key,
    @required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedButton(
        controller: _controller,
        icon: Icons.layers,
        tag: 'Layers',
        onTap: () {
          return true;
        });
  }
}

class LocationButton extends StatelessWidget {
  const LocationButton({
    Key key,
    @required this.mc,
    @required this.mo,
  }) : super(key: key);

  final MapConditions mc;
  final MapOffset mo;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedButton(
        icon: Icons.location_searching,
        tag: 'Locate',
        onTap: () {
          if (mc.currentLocationMarker == null) {
            return mc.searchLocation().then(
              (_) {
                Future.delayed(
                  Duration(milliseconds: 100),
                  () {
                    mo.moveTo(mc.currentLocationMarker);
                  },
                );
                return mc.currentLocationCoordinates != LatLng(90, 90);
              },
            );
          } else {
            mc.removeCurrentLocation();
            return true;
          }
        });
  }
}
