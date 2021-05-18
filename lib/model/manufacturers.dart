/// status_code : 200
/// message : "success"
/// data : [{"id":1,"manufacturer_name":"BOSCH","lang":"ar"}]

class Manufacturers {
  int _statusCode;
  String _message;
  List<Manufacturer> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Manufacturer> get data => _data;

  Manufacturers({int statusCode, String message, List<Manufacturer> data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  Manufacturers.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Manufacturer.fromJson(v));
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
/// manufacturer_name : "BOSCH"
/// lang : "ar"

class Manufacturer {
  int _id;
  String _manufacturerName;
  String _lang;
  bool check = false;

  int get id => _id;
  String get manufacturerName => _manufacturerName;
  String get lang => _lang;

  Manufacturer({int id, String manufacturerName, String lang}) {
    _id = id;
    _manufacturerName = manufacturerName;
    _lang = lang;
  }

  Manufacturer.fromJson(dynamic json) {
    _id = json["id"];
    _manufacturerName = json["manufacturer_name"];
    _lang = json["lang"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["manufacturer_name"] = _manufacturerName;
    map["lang"] = _lang;
    return map;
  }
}
