/// status_code : 200
/// message : "success"
/// data : [{"id":85,"name":"البطاريات","description":"البطاريات","created_at":"2021-06-23 10:36:02","updated_at":"2021-06-23 10:36:02","lang":"ar","maincategory_id":7,"photo":{"id":355,"conversions_disk":"public","responsive_images":[],"order_column":349,"image":"https://traker.fra1.digitaloceanspaces.com/product-categories/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB.jpg","url":"https://development.lacasacode.dev/storage/355/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB.jpg","fullurl":"https://development.lacasacode.dev/storage/355/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB.jpg","thumbnail":"https://development.lacasacode.dev/storage/355/conversions/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB-thumb.jpg","preview":"https://development.lacasacode.dev/storage/355/conversions/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB-preview.jpg"}}]

class ProductMostView {
  int _statusCode;
  String _message;
  List<ProductMost> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<ProductMost> get data => _data;

  ProductMostView({
      int statusCode, 
      String message, 
      List<ProductMost> data}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  ProductMostView.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(ProductMost.fromJson(v));
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

/// id : 85
/// name : "البطاريات"
/// description : "البطاريات"
/// created_at : "2021-06-23 10:36:02"
/// updated_at : "2021-06-23 10:36:02"
/// lang : "ar"
/// maincategory_id : 7
/// photo : {"id":355,"conversions_disk":"public","responsive_images":[],"order_column":349,"image":"https://traker.fra1.digitaloceanspaces.com/product-categories/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB.jpg","url":"https://development.lacasacode.dev/storage/355/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB.jpg","fullurl":"https://development.lacasacode.dev/storage/355/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB.jpg","thumbnail":"https://development.lacasacode.dev/storage/355/conversions/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB-thumb.jpg","preview":"https://development.lacasacode.dev/storage/355/conversions/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB-preview.jpg"}

class ProductMost {
  int _id;
  String _name;
  String _description;
  String _createdAt;
  String _updatedAt;
  String _lang;
  int _maincategoryId;
  Photo _photo;

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get lang => _lang;
  int get maincategoryId => _maincategoryId;
  Photo get photo => _photo;

  ProductMost({
      int id, 
      String name, 
      String description, 
      String createdAt, 
      String updatedAt, 
      String lang, 
      int maincategoryId, 
      Photo photo}){
    _id = id;
    _name = name;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _lang = lang;
    _maincategoryId = maincategoryId;
    _photo = photo;
}

  ProductMost.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _description = json["description"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _lang = json["lang"];
    _maincategoryId = json["maincategory_id"];
    _photo = json["photo"] != null ? Photo.fromJson(json["photo"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["description"] = _description;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["lang"] = _lang;
    map["maincategory_id"] = _maincategoryId;
    if (_photo != null) {
      map["photo"] = _photo.toJson();
    }
    return map;
  }

}

/// id : 355
/// conversions_disk : "public"
/// responsive_images : []
/// order_column : 349
/// image : "https://traker.fra1.digitaloceanspaces.com/product-categories/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB.jpg"
/// url : "https://development.lacasacode.dev/storage/355/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB.jpg"
/// fullurl : "https://development.lacasacode.dev/storage/355/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB.jpg"
/// thumbnail : "https://development.lacasacode.dev/storage/355/conversions/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB-thumb.jpg"
/// preview : "https://development.lacasacode.dev/storage/355/conversions/HLOQpVNwCHCHipR834g19B2uPzfd6qAasjAUA5HB-preview.jpg"

class Photo {
  int _id;
  String _conversionsDisk;
  List<dynamic> _responsiveImages;
  int _orderColumn;
  String _image;
  String _url;
  String _fullurl;
  String _thumbnail;
  String _preview;

  int get id => _id;
  String get conversionsDisk => _conversionsDisk;
  List<dynamic> get responsiveImages => _responsiveImages;
  int get orderColumn => _orderColumn;
  String get image => _image;
  String get url => _url;
  String get fullurl => _fullurl;
  String get thumbnail => _thumbnail;
  String get preview => _preview;

  Photo({
      int id, 
      String conversionsDisk, 
      List<dynamic> responsiveImages, 
      int orderColumn, 
      String image, 
      String url, 
      String fullurl, 
      String thumbnail, 
      String preview}){
    _id = id;
    _conversionsDisk = conversionsDisk;
    _responsiveImages = responsiveImages;
    _orderColumn = orderColumn;
    _image = image;
    _url = url;
    _fullurl = fullurl;
    _thumbnail = thumbnail;
    _preview = preview;
}

  Photo.fromJson(dynamic json) {
    _id = json["id"];
    _conversionsDisk = json["conversions_disk"];

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
    map["conversions_disk"] = _conversionsDisk;
    if (_responsiveImages != null) {
      map["responsive_images"] = _responsiveImages.map((v) => v.toJson()).toList();
    }
    map["order_column"] = _orderColumn;
    map["image"] = _image;
    map["url"] = _url;
    map["fullurl"] = _fullurl;
    map["thumbnail"] = _thumbnail;
    map["preview"] = _preview;
    return map;
  }

}