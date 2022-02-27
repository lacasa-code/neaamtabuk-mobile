import 'package:flutter_pos/model/ads.dart';

class Categories_model {
  String message;
  List<Categories_item> data;

  Categories_model({this.message, this.data});

  Categories_model.fromJson(Map<String, dynamic> json) {
   // statusCode = json['status_code'];
    //message = json['message'];
    if (json['data'] != null) {
      data = new List<Categories_item>();
      json['data'].forEach((v) {
        data.add(new Categories_item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories_item {
  int id;
  String name;
  String slug_en;


  Categories_item(
      {this.id,
        this.name,
        this.slug_en});

  Categories_item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name_en'];
    slug_en = json['slug_en'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.name;
    data['slug_en'] = this.slug_en;
    return data;
  }
}


