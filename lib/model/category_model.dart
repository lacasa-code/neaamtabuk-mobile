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

class Photo {
  int _id;
  String _modelType;
  int _modelId;
  String _uuid;
  String _collectionName;
  String _name;
  String _fileName;
  String _mimeType;
  String _disk;
  String _conversionsDisk;
  int _size;
  int _orderColumn;
  String _image;
  String _url;
  String _fullurl;
  String _thumbnail;
  String _preview;

  int get id => _id;
  String get modelType => _modelType;
  int get modelId => _modelId;
  String get uuid => _uuid;
  String get collectionName => _collectionName;
  String get name => _name;
  String get fileName => _fileName;
  String get mimeType => _mimeType;
  String get disk => _disk;
  String get conversionsDisk => _conversionsDisk;
  int get size => _size;
  int get orderColumn => _orderColumn;
  String get image => _image;
  String get url => _url;
  String get fullurl => _fullurl;
  String get thumbnail => _thumbnail;
  String get preview => _preview;

  Photo(
      {int id,
      String modelType,
      int modelId,
      String uuid,
      String collectionName,
      String name,
      String fileName,
      String mimeType,
      String disk,
      String conversionsDisk,
      int size,
      int orderColumn,
      String image,
      String url,
      String fullurl,
      String thumbnail,
      String preview}) {
    _id = id;
    _modelType = modelType;
    _modelId = modelId;
    _uuid = uuid;
    _collectionName = collectionName;
    _name = name;
    _fileName = fileName;
    _mimeType = mimeType;
    _disk = disk;
    _conversionsDisk = conversionsDisk;
    _size = size;
    _orderColumn = orderColumn;
    _image = image;
    _url = url;
    _fullurl = fullurl;
    _thumbnail = thumbnail;
    _preview = preview;
  }

  Photo.fromJson(dynamic json) {
    _id = json["id"];
    _modelType = json["model_type"];
    _modelId = json["model_id"];
    _uuid = json["uuid"];
    _collectionName = json["collection_name"];
    _name = json["name"];
    _fileName = json["file_name"];
    _mimeType = json["mime_type"];
    _disk = json["disk"];
    _conversionsDisk = json["conversions_disk"];
    _size = json["size"];
    _orderColumn = json["order_column"];
    _image = json["image"];
    _url = json["url"];
    _fullurl = json["fullurl"];
    _thumbnail = json["thumbnail"];
    _preview = json["preview"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["model_type"] = _modelType;
    map["model_id"] = _modelId;
    map["uuid"] = _uuid;
    map["collection_name"] = _collectionName;
    map["name"] = _name;
    map["file_name"] = _fileName;
    map["mime_type"] = _mimeType;
    map["disk"] = _disk;
    map["conversions_disk"] = _conversionsDisk;
    map["size"] = _size;
    map["order_column"] = _orderColumn;
    map["image"] = _image;
    map["url"] = _url;
    map["fullurl"] = _fullurl;
    map["thumbnail"] = _thumbnail;
    map["preview"] = _preview;
    return map;
  }
}
