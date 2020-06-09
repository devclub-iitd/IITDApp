import 'package:flutter/foundation.dart';

class CarouselIndex with ChangeNotifier {
  int _current = 0;
  void setCurrent(int i) {
    _current = i;
    notifyListeners();
  }

  int getCurrent() {
    return _current;
  }
}
