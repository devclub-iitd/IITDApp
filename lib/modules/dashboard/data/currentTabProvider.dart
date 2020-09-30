import 'package:flutter/foundation.dart';
class CurrentTabProvider with ChangeNotifier{
  int _currentIndex =0;
  bool isCurrent(i)=>_currentIndex==i;
  void setCurrent(i)=>_currentIndex=i;
}