import 'package:IITDAPP/modules/map/data/mapOffsets.dart';
import 'package:IITDAPP/modules/map/widgets/marker/selectedMarker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/modules/map/data/mapCondition.dart';
import 'package:IITDAPP/modules/map/widgets/marker/marker.dart';

class MarkerIcon extends StatefulWidget {
  const MarkerIcon({
    Key key,
    @required this.m,
  }) : super(key: key);

  final Marker m;

  @override
  _MarkerIconState createState() => _MarkerIconState();
}

class _MarkerIconState extends State<MarkerIcon> with TickerProviderStateMixin {
  Tween<Offset> tweenOffset =
      Tween<Offset>(begin: Offset(0, -24), end: Offset(0, 0));

  AnimationController _controller;
  Animation<double> _animation;
  bool _selected;

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
    var mc = Provider.of<MapConditions>(context, listen: false);
    _selected = mc.selectedMarker == widget.m.id;
    // print(widget.m.id.toString() + ' $previouslySelected');
    if (!_controller.isAnimating) {
      _controller.value = 1;
    }
    if (mc.play[widget.m.id]) {
      mc.play[widget.m.id] = false;
      if (!_controller.isAnimating) {
        _controller.reset();
      }
      _controller.forward(from: _controller.value);
    }

    return _selected
        ? SelectedMarker(animation: _animation)
        : Container(
            decoration: BoxDecoration(
              color: mc.bgcolor[widget.m.id],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              constraints:
                  BoxConstraints.tight(Size(widget.m.size, widget.m.size)),
              icon: widget.m,
              onPressed: () {
                mc.markerSelected(widget.m.id);
                Provider.of<MapOffset>(context, listen: false).moveTo(widget.m);
              },
            ));
  }
}
