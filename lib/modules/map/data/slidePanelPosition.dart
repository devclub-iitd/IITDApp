import 'package:flutter/material.dart';

class SlidePanelPosition extends ChangeNotifier {
  double position = 0; // to move floating action button
  void setPosition(h) {
    position = h;
    notifyListeners();
  }
}
