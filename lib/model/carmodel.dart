/// status_code : 200
/// message : "success"
/// data : [{"id":1,"carmodel":"first model","carmade_id":2}]

class Carmodel {
  int _statusCode;
  String _message;
  List<CarModel> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<CarModel> get data => _data;

  Carmodel({int statusCode, String message, List<CarModel> data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  Carmodel.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(CarModel.fromJson(v));
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
/// carmodel : "first model"
/// carmade_id : 2

class CarModel {
  int _id;
  String _carmodel;
  int _carmadeId;

  int get id => _id;
  String get carmodel => _carmodel;
  int get carmadeId => _carmadeId;

  CarModel({int id, String carmodel, int carmadeId}) {
    _id = id;
    _carmodel = carmodel;
    _carmadeId = carmadeId;
  }

  CarModel.fromJson(dynamic json) {
    _id = json["id"];
    _carmodel = json["carmodel"];
    _carmadeId = json["carmade_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["carmodel"] = _carmodel;
    map["carmade_id"] = _carmadeId;
    return map;
  }
}
