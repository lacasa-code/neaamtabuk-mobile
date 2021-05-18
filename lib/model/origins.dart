/// status_code : 200
/// message : "success"
/// data : [{"id":1,"country_name":"after edit","country_code":"DE","lang":"ar"}]

class Origins {
  int _statusCode;
  String _message;
  List<Origin> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Origin> get data => _data;

  Origins({int statusCode, String message, List<Origin> data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  Origins.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Origin.fromJson(v));
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
/// country_name : "after edit"
/// country_code : "DE"
/// lang : "ar"

class Origin {
  int _id;
  String _countryName;
  String _countryCode;
  String _lang;
  bool check = false;

  int get id => _id;
  String get countryName => _countryName;
  String get countryCode => _countryCode;
  String get lang => _lang;

  Origin({int id, String countryName, String countryCode, String lang}) {
    _id = id;
    _countryName = countryName;
    _countryCode = countryCode;
    _lang = lang;
  }

  Origin.fromJson(dynamic json) {
    _id = json["id"];
    _countryName = json["country_name"];
    _countryCode = json["country_code"];
    _lang = json["lang"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["country_name"] = _countryName;
    map["country_code"] = _countryCode;
    map["lang"] = _lang;
    return map;
  }
}
