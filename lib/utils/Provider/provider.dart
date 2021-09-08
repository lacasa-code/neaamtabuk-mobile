
import 'package:flutter/material.dart';

class Provider_control with ChangeNotifier {
  Color _themeData = Color(0xff424242);
  String local;
  String car_made =  'إختر المركبة';
  // 1 = approved
  // 2 = rejected
  // 3 = declined
  // 4 = pending
  int Complete ;
  int car_type =  1;
  int index =  0;
  Color color;
  bool isLogin = false;
  Provider_control(this.local){
    if(this.local=='en'){
      car_made='Select Car';
    }else if(this.local=='ar'){
      car_made='إختر المركبة';
    }
  }
  getColor() => _themeData;
  getCar_made() => car_made;
  getcar_type() => car_type;
  getcar_index() => index;
  getlocal() => local;

  setComplete(int complete) async {
    Complete = complete;
    notifyListeners();
  }
  setCar_made(String CarMade) async {
    car_made = CarMade;
    notifyListeners();
  }
setCar_type(int CarType) async {
  car_type = CarType;
    notifyListeners();
  }
  setCar_index(int CarType) async {
  index = CarType;
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
