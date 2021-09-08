import 'package:flutter_pos/model/ads.dart';

class Category_model {
  int statusCode;
  String message;
  List<Main_Category> data;

  Category_model({this.statusCode, this.message, this.data});

  Category_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Main_Category>();
      json['data'].forEach((v) {
        data.add(new Main_Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Main_Category {
  int id;
  String mainCategoryName;
  String nameEn;
  List<Categories> categories;
  String lang;
  int last_level;
  String createdAt;

  Main_Category(
      {this.id,
        this.mainCategoryName,
        this.nameEn,
        this.categories,
        this.lang,
        this.last_level,
        this.createdAt});

  Main_Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainCategoryName = json['main_category_name'];
    nameEn = json['name_en'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    lang = json['lang'];
    last_level = json['last_level'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main_category_name'] = this.mainCategoryName;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['lang'] = this.lang;
    data['status'] = this.last_level;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Categories {
  int id;
  String name;
  String name_en;
  bool Check=false;

  String description;
  List<PartCategories> partCategories;
  String lang;
  int last_level;
  String createdAt;

  Categories(
      {this.id,
        this.name,
        this.name_en,
        this.description,
        this.partCategories,
        this.lang,
        this.last_level,
        this.createdAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_en = json['name_en'];
    description = json['description'];
    if (json['part_categories'] != null) {
      partCategories = new List<PartCategories>();
      json['part_categories'].forEach((v) {
        partCategories.add(new PartCategories.fromJson(v));
      });
    }
    lang = json['lang'];
    last_level = json['last_level'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;

    data['lang'] = this.lang;
    data['status'] = this.last_level;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class PartCategories {
  int id;
  String categoryName;
  String name_en;
  String lang;
  String createdAt;
  bool partsCheck=false;

  Photo photo;
  int last_level;
  PartCategories(
      {this.id,
        this.categoryName,this.photo,
        this.lang,
        this.createdAt});

  PartCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    name_en = json['name_en'];
    if (json['photo'] != null) {
        photo = Photo.fromJson(json['photo']);
    }
    lang = json['lang'];
    last_level = json['last_level'];
    createdAt = json['created_at'];
  }

}
