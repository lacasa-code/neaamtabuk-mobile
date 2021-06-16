
import 'package:flutter/material.dart';

class Provider_control with ChangeNotifier {
  Color _themeData = Color(0xff424242);
  String local = 'ar';
  String car_made =  'إختر المركبة';
  Color color;
  bool isLogin = false;
  Provider_control();
  getColor() => _themeData;
  getCar_made() => car_made;
  getlocal() => local;

  setCar_made(String Car_made) async {
    car_made = Car_made;
    notifyListeners();
  }

  setColor(Color themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  setLogin(bool isLog) {
    isLogin = isLog;
    notifyListeners();
  }

  setLocal(String st) {
    local = st;
    if(st=='en'){
      car_made='Select Car';
    }else if(st=='ar'){
      car_made='إختر المركبة';
    }
    notifyListeners();
  }
}
