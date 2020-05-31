import 'package:IITDAPP/modules/map/widgets/marker/markerLabel.dart';
import 'package:IITDAPP/modules/map/widgets/marker/selectedMarker.dart';
import 'package:IITDAPP/values/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/modules/map/data/mapCondition.dart';
import 'package:IITDAPP/modules/map/widgets/marker/marker.dart';

class CurrentLocationMarker extends StatefulWidget {
  final MinScaleLevel minScale = null;

  CurrentLocationMarker();

  @override
  _CurrentLocationMarkerState createState() => _CurrentLocationMarkerState();
}

class _CurrentLocationMarkerState extends State<CurrentLocationMarker>
    with TickerProviderStateMixin {
  var mc;

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInSine);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mc = Provider.of<MapConditions>(context);
    mc.onScreenOffset.last = mc.currentLocationOffset;
    if (!_controller.isAnimating) {
      _controller.value = 1;
    }
    if (mc.searchTapped) {
      mc.searchTapped = false;

      if (!_controller.isAnimating) {
        _controller.reset();
      }
      _controller.forward(from: _controller.value);
    }

    return Positioned(
      left: mc.onScreenOffset.last.dx - SelectedMarker.selectedIconSize / 2,
      top: mc.onScreenOffset.last.dy - SelectedMarker.selectedIconSize * 3 / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.scale(
            scale: 0.5,
            child: ScaleTransition(
              scale: _animation,
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.location_on,
                color: AppColors.CURRENT_LOCATION_COLOR,
                size: SelectedMarker.selectedIconSize,
              ),
            ),
          ),
          MarkerLabel(
              label: 'You',
              color: AppColors.CURRENT_LOCATION_LABEL_COLOR,
              y: -SelectedMarker.selectedIconSize * 3 / 4)
        ],
      ),
    );
  }
}
