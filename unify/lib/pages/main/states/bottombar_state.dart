import 'package:flutter/foundation.dart';

enum BottomBarStateEnum {
  V2RAY,
  SSR,
}

class BottomBarState with ChangeNotifier {
  BottomBarStateEnum _curType = BottomBarStateEnum.V2RAY;
  get curType => _curType;
  set curType(c) {
    _curType = c;
    notifyListeners();
  }
}
