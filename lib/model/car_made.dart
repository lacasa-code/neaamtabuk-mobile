/// status_code : 200
/// message : "success"
/// data : [{"id":2,"car_made":"BMW2","categoryid_id":1}]

class Car_made {
  int _statusCode;
  String _message;
  List<CarMade> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<CarMade> get data => _data;

  Car_made({int statusCode, String message, List<CarMade> data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  Car_made.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(CarMade.fromJson(v));
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

/// id : 2
/// car_made : "BMW2"
/// categoryid_id : 1

class CarMade {
  int _id;
  String _carMade;
  int _categoryidId;

  int get id => _id;
  String get carMade => _carMade;
  int get categoryidId => _categoryidId;

  CarMade({int id, String carMade, int categoryidId}) {
    _id = id;
    _carMade = carMade;
    _categoryidId = categoryidId;
  }

  CarMade.fromJson(dynamic json) {
    _id = json["id"];
    _carMade = json["car_made"];
    _categoryidId = json["categoryid_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["car_made"] = _carMade;
    map["categoryid_id"] = _categoryidId;
    return map;
  }
}
