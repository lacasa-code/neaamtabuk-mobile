/// status_code : 200
/// message : "success"
/// data : [{"id":2,"user_id":53,"user_name":"asd","car_made_id":2,"car_made_name":"BMW2"}]
/// total : 1

class Favourite {
  int _statusCode;
  String _message;
  List<Fav> _data;
  int _total;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Fav> get data => _data;
  int get total => _total;

  Favourite({int statusCode, String message, List<Fav> data, int total}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
    _total = total;
  }

  Favourite.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Fav.fromJson(v));
      });
    }
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["total"] = _total;
    return map;
  }
}

/// id : 2
/// user_id : 53
/// user_name : "asd"
/// car_made_id : 2
/// car_made_name : "BMW2"

class Fav {
  int _id;
  int _userId;
  String _userName;
  int _carMadeId;
  String _carMadeName;

  int get id => _id;
  int get userId => _userId;
  String get userName => _userName;
  int get carMadeId => _carMadeId;
  String get carMadeName => _carMadeName;

  Fav(
      {int id,
      int userId,
      String userName,
      int carMadeId,
      String carMadeName}) {
    _id = id;
    _userId = userId;
    _userName = userName;
    _carMadeId = carMadeId;
    _carMadeName = carMadeName;
  }

  Fav.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _userName = json["user_name"];
    _carMadeId = json["car_made_id"];
    _carMadeName = json["car_made_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["user_name"] = _userName;
    map["car_made_id"] = _carMadeId;
    map["car_made_name"] = _carMadeName;
    return map;
  }
}
