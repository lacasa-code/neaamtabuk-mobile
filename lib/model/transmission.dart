/// status_code : 200
/// message : "success"
/// data : [{"id":1,"transmission_name":"manual","status":1}]

class Transmission {
  int _statusCode;
  String _message;
  List<Transmissions> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Transmissions> get data => _data;

  Transmission({int statusCode, String message, List<Transmissions> data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  Transmission.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Transmissions.fromJson(v));
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
/// transmission_name : "manual"
/// status : 1

class Transmissions {
  int _id;
  String _transmissionName;
  int _status;

  int get id => _id;
  String get transmissionName => _transmissionName;
  int get status => _status;

  Transmissions({int id, String transmissionName, int status}) {
    _id = id;
    _transmissionName = transmissionName;
    _status = status;
  }

  Transmissions.fromJson(dynamic json) {
    _id = json["id"];
    _transmissionName = json["transmission_name"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["transmission_name"] = _transmissionName;
    map["status"] = _status;
    return map;
  }
}
