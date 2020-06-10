import 'package:flutter/material.dart';

class SelectedMarker extends StatelessWidget {
  const SelectedMarker({
    Key key,
    @required Animation<double> animation,
  })  : _animation = animation,
        super(key: key);

  final Animation<double> _animation;
  static final double selectedIconSize = 70;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      alignment: Alignment.bottomCenter,
      child: Icon(
        Icons.location_on,
        color: Colors.black,
        size: selectedIconSize,
      ),
    );
  }
}
