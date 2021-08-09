import 'package:flutter/material.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/model/product_most_view.dart';
import 'package:flutter_pos/model/shipping_address.dart';
import 'package:flutter_pos/service/api.dart';

class Provider_Data with ChangeNotifier {
  Cart_model cart_model;
  Address address;
  List<Product> product,productMostSale;
  List<ProductMost> productMostView;

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
  getData(int cartypeId,BuildContext context) {
    API(context, Check: false)
        .get('site/new/products?cartype_id=$cartypeId')
        .then((value) {
      if (value != null) {
          product = Product_model.fromJson(value).data;
      }
    });
    API(context)
        .get('mostly/viewed/products?cartype_id=$cartypeId')
        .then((value) {
      if (value != null) {
          productMostView = ProductMostView.fromJson(value).data;
      }
    });
    API(context)
        .get('best/seller/products?cartype_id=$cartypeId')
        .then((value) {
      if (value != null) {
          productMostSale = Product_model.fromJson(value).data;
      }
    });
    notifyListeners();
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
