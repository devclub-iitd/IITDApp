import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class DarkModeSwitch extends StatelessWidget {
  final bool isOn;
  final VoidCallback onToggle;
  final bool snapToEnd;

  const DarkModeSwitch(this.isOn, {this.snapToEnd, this.onToggle});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onToggle,
        child: Container(
            width: 200,
            height: 100,
            child: FlareActor('assets/flare/dm.flr',
                animation: isOn ? 'Dark to light' : 'Light to dark')));
  }
}
