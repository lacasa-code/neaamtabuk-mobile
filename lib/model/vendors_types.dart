/// status_code : 200
/// message : "success"
/// data : [{"id":1,"type":"vendor","status":1,"lang":"ar"},{"id":2,"type":"hot sale","status":1,"lang":"ar"},{"id":3,"type":"Both","status":1,"lang":"ar"}]

class Vendors_types {
  int _statusCode;
  String _message;
  List<vendor_types> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<vendor_types> get data => _data;

  Vendors_types({
      int statusCode, 
      String message, 
      List<vendor_types> data}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  Vendors_types.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(vendor_types.fromJson(v));
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
/// type : "vendor"
/// status : 1
/// lang : "ar"

class vendor_types {
  int _id;
  String _type;
  int _status;
  String _lang;

  int get id => _id;
  String get type => _type;
  int get status => _status;
  String get lang => _lang;

  vendor_types({
      int id, 
      String type, 
      int status, 
      String lang}){
    _id = id;
    _type = type;
    _status = status;
    _lang = lang;
}

  vendor_types.fromJson(dynamic json) {
    _id = json["id"];
    _type = json["type"];
    _status = json["status"];
    _lang = json["lang"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["type"] = _type;
    map["status"] = _status;
    map["lang"] = _lang;
    return map;
  }

}