import 'package:flutter_pos/model/product_model.dart';

/// status_code : 200
/// message : "success"
/// data : [{"id":1,"name":"first categoryEdit Category Name","description":"first category description12","lang":"ar","photo":{"id":31,"model_type":"App\\Models\\ProductCategory","model_id":1,"uuid":"55a6cd24-341f-4e25-b2a5-389e823fb8f0","collection_name":"photo","name":"GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9","file_name":"GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg","mime_type":"image/jpeg","disk":"public","conversions_disk":"public","size":356466,"order_column":28,"image":"https://traker.fra1.digitaloceanspaces.com/product-categories/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg","url":"https://development.lacasacode.dev/storage/31/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg","fullurl":"https://development.lacasacode.dev/storage/31/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg","thumbnail":"https://development.lacasacode.dev/storage/31/conversions/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9-thumb.jpg","preview":"https://development.lacasacode.dev/storage/31/conversions/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9-preview.jpg"}}]

class Category_model {
  int _statusCode;
  String _message;
  List<Category> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Category> get data => _data;

  Category_model({int statusCode, String message, List<Category> data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  Category_model.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "first categoryEdit Category Name"
/// description : "first category description12"
/// lang : "ar"
/// photo : {"id":31,"model_type":"App\\Models\\ProductCategory","model_id":1,"uuid":"55a6cd24-341f-4e25-b2a5-389e823fb8f0","collection_name":"photo","name":"GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9","file_name":"GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg","mime_type":"image/jpeg","disk":"public","conversions_disk":"public","size":356466,"order_column":28,"image":"https://traker.fra1.digitaloceanspaces.com/product-categories/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg","url":"https://development.lacasacode.dev/storage/31/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg","fullurl":"https://development.lacasacode.dev/storage/31/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg","thumbnail":"https://development.lacasacode.dev/storage/31/conversions/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9-thumb.jpg","preview":"https://development.lacasacode.dev/storage/31/conversions/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9-preview.jpg"}

class Category {
  int _id;
  String _name;
  String _description;
  String _lang;
  Photo _photo;

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get lang => _lang;
  Photo get photo => _photo;

  Category(
      {int id, String name, String description, String lang, Photo photo}) {
    _id = id;
    _name = name;
    _description = description;
    _lang = lang;
    _photo = photo;
  }

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _description = json["description"];
    _lang = json["lang"];
    _photo = json["photo"] != null ? Photo.fromJson(json["photo"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["description"] = _description;
    map["lang"] = _lang;
    if (_photo != null) {
      map["photo"] = _photo.toJson();
    }
    return map;
  }
}

/// id : 31
/// model_type : "App\\Models\\ProductCategory"
/// model_id : 1
/// uuid : "55a6cd24-341f-4e25-b2a5-389e823fb8f0"
/// collection_name : "photo"
/// name : "GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9"
/// file_name : "GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg"
/// mime_type : "image/jpeg"
/// disk : "public"
/// conversions_disk : "public"
/// size : 356466
/// order_column : 28
/// image : "https://traker.fra1.digitaloceanspaces.com/product-categories/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg"
/// url : "https://development.lacasacode.dev/storage/31/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg"
/// fullurl : "https://development.lacasacode.dev/storage/31/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9.jpg"
/// thumbnail : "https://development.lacasacode.dev/storage/31/conversions/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9-thumb.jpg"
/// preview : "https://development.lacasacode.dev/storage/31/conversions/GMBrUb3WOI6srvS08ljBhyifxKsPr5VZMbbUaGF9-preview.jpg"
