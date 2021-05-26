
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/service/api.dart';

class Provider_Data with ChangeNotifier {
  Cart_model cart_model;


  Provider_Data();

  getCart_model() => cart_model;
  getCart(BuildContext context) {
    API(context).post('show/cart', {}).then((value) {
      if (value != null) {
        cart_model = Cart_model.fromJson(value);
        notifyListeners();
      }
    });
  }
}
