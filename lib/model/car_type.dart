/// status_code : 200
/// message : "success"
/// data : [{"id":1,"type_name":"سيارات ركوب A","lang":"ar"}]

class Car_type {
  int _statusCode;
  String _message;
  List<CarType> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<CarType> get data => _data;

  Car_type({int statusCode, String message, List<CarType> data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  Car_type.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(CarType.fromJson(v));
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
/// type_name : "سيارات ركوب A"
/// lang : "ar"

class CarType {
  int _id;
  String _typeName;
  String _lang;
  String _image;

  int get id => _id;
  String get typeName => _typeName;
  String get lang => _lang;
  String get image => _image;

  CarType({int id, String typeName, String lang}) {
    _id = id;
    _typeName = typeName;
    _lang = lang;
    _image = image;
  }

  CarType.fromJson(dynamic json) {
    _id = json["id"];
    _typeName = json["type_name"];
    _lang = json["lang"];
    _image = json["photo"]["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["type_name"] = _typeName;
    map["lang"] = _lang;
    return map;
  }
}
