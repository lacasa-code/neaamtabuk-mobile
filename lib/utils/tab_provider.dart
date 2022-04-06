import 'package:flutter/foundation.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/shared_prefs_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabProvider with ChangeNotifier {
  int _index = 2;
  int get index => _index;

  toHome() {
    _index = 2;
    notifyListeners();
  }

  changeIndex(
    context,
    theme,
    int i,
  ) {
    if (i == 4) {
      theme.setLogin(false);
      final SharedPreferences prefs =
          Provider.of<SharedPrefsProvider>(context, listen: false).prefs;
      prefs.clear();
      theme.isLogin
          ? Nav.routeReplacement(context, Home())
          : Nav.route(
              context,
              LoginPage(),
            );
      return;
    }
    if (i == 2) {
      return;
    } else {
      _index = i;
      notifyListeners();
    }
  }
}
