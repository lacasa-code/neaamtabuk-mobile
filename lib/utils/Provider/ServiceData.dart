import 'package:flutter/material.dart';
import 'package:flutter_pos/model/Categories_model.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/model/product_most_view.dart';
import 'package:flutter_pos/model/shipping_address.dart';
import 'package:flutter_pos/service/api.dart';

class ProviderData with ChangeNotifier {
   Cart_model cart_model;
   Address address;
   List<Product> product,productMostSale;
   List<ProductMost> productMostView;
   List<Categories_item> categories;
   List<Categories_item> Mostcategories;
   List<Product> wishList;
   ProviderData();
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
        .get('ahmed/new/products?cartype_id=$cartypeId&per_page=6')
        .then((value) {
      if (value != null) {
          product = Product_model.fromJson(value).data;
      }
    });
    API(context)
        .get('most/viewed/products?cartype_id=$cartypeId')
        .then((value) {
      print(value);
      if (value != null) {
        productMostView = ProductMostView.fromJson(value).data;
      }
    });
    API(context)
        .get('ahmed/best/seller/products?cartype_id=$cartypeId&per_page=6')
        .then((value) {
      if (value != null) {
          productMostSale = Product_model.fromJson(value).data;
      }
    });
    API(context).get('home/allcategories/navbars/$cartypeId').then((value) {
      if (value != null) {
        print(value);
          Mostcategories = Categories_model.fromJson(value).data;
      }
    });
    API(context).get('home/allcategories').then((value) {
      if (value != null) {
        categories = Categories_model.fromJson(value).data;
      }
    });
    notifyListeners();
  }
   getWishlist(BuildContext context) {
    API(context).get('user/get/wishlist').then((value) {
      if (value != null) {
          wishList = Product_model.fromJson(value).data;
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
