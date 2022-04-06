import 'dart:developer';

import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider({this.currentTabIndex}) {
    log('message ${currentTabIndex == null}');
    if (currentTabIndex != null) {
      changeTabIndex(currentTabIndex);
      log('message $currentTabIndex');
    }
  }
  int currentTabIndex;
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  changeTabIndex(int newIndex) {
    _tabIndex = newIndex;
    log('object $_tabIndex');
    notifyListeners();
  }
}
