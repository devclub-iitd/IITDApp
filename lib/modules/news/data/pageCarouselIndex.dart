import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PageCarouselIndex with ChangeNotifier {
  final ItemScrollController isc = ItemScrollController();
  final CarouselController cc = CarouselController();
  final double width;
  final int pages;
  int _current = 0;
  bool isAnimating = false;

  PageCarouselIndex(this.width, this.pages, this._current);
  void setCurrent(int i) {
    _current = i;
    isc.scrollTo(
        index: i,
        duration: Duration(milliseconds: 400),
        alignment: 0.5 - 20 / (width - 196));
    isAnimating = true;
    cc.animateToPage(i, duration: Duration(milliseconds: 400));
    Future.delayed(Duration(milliseconds: 400), () => isAnimating = false);
    notifyListeners();
  }

  int get current {
    return _current;
  }

  void moveRight() {
    setCurrent(_current + 1 == 50 ? 49 : _current + 1);
  }

  void moveLeft() {
    setCurrent(_current - 1 < 0 ? 0 : _current - 1);
  }
}
