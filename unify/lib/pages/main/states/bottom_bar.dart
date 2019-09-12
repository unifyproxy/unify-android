import 'package:flutter/foundation.dart';

class BottomBarState with ChangeNotifier {
  int _curIndex = 0;
  get curIndex => _curIndex;
  set curIndex(c) {
    _curIndex = c;
    notifyListeners();
  }
}
