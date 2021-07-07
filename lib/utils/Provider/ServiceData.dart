import 'package:flutter/material.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/model/shipping_address.dart';
import 'package:flutter_pos/service/api.dart';

class Provider_Data with ChangeNotifier {
  Cart_model cart_model;
  Address address;

  Provider_Data();

  getCart_model() => cart_model;

  getCart(BuildContext context) {
    API(context, Check: false).post('show/cart', {}).then((value) {
      if (value != null) {
        print(value);
        cart_model = Cart_model.fromJson(value);
        notifyListeners();
      }
    });
  }

  getShipping(BuildContext context) {
    API(context, Check: false).get('user/get/default/shipping').then((value) {
      if (value != null) {
        if (value['status_code'] == 200) {
          value['data'] == null
              ? null
              : address = Address.fromJson(value['data']);
          notifyListeners();
        }
      }
    });
  }

  setShipping(Address address) {
    this.address = address;
    notifyListeners();
  }
}
