import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsProvider with ChangeNotifier {
  SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;

  Future<SharedPreferences> getInstance() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
    return _prefs;
  }
}
