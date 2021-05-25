/// status_code : 200
/// message : "success"
/// data : [{"id":1,"user_id":3,"user_name":"firstuser","status":1,"recipient_name":"first user","recipient_phone":"966507777777","recipient_alt_phone":null,"recipient_email":"firstuser@user.com","address":"first user address","city":"first user city","state":"saudi","country_code":"sa","postal_code":"000","latitude":"40.11111","longitude":"40.1111","time_created":"2021-05-19 08:31:38"}]
/// total : 1

class ShippingAddress {
  int _statusCode;
  String _message;
  List<Address> _data;
  int _total;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Address> get data => _data;
  int get total => _total;

  ShippingAddress({
      int statusCode, 
      String message, 
      List<Address> data, 
      int total}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
    _total = total;
}

  ShippingAddress.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Address.fromJson(v));
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

/// id : 1
/// user_id : 3
/// user_name : "firstuser"
/// status : 1
/// recipient_name : "first user"
/// recipient_phone : "966507777777"
/// recipient_alt_phone : null
/// recipient_email : "firstuser@user.com"
/// address : "first user address"
/// city : "first user city"
/// state : "saudi"
/// country_code : "sa"
/// postal_code : "000"
/// latitude : "40.11111"
/// longitude : "40.1111"
/// time_created : "2021-05-19 08:31:38"

class Address {
  int _id;
  int _userId;
  String _userName;
  int _status;
  String _recipientName;
  String _recipientPhone;
  dynamic _recipientAltPhone;
  String _recipientEmail;
  String _address;
  String _city;
  String _state;
  String _countryCode;
  String _postalCode;
  String _latitude;
  String _longitude;
  String _timeCreated;

  int get id => _id;
  int get userId => _userId;
  String get userName => _userName;
  int get status => _status;
  String get recipientName => _recipientName;
  String get recipientPhone => _recipientPhone;
  dynamic get recipientAltPhone => _recipientAltPhone;
  String get recipientEmail => _recipientEmail;
  String get address => _address;
  String get city => _city;
  String get state => _state;
  String get countryCode => _countryCode;
  String get postalCode => _postalCode;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get timeCreated => _timeCreated;

  Address({
      int id, 
      int userId, 
      String userName, 
      int status, 
      String recipientName, 
      String recipientPhone, 
      dynamic recipientAltPhone, 
      String recipientEmail, 
      String address, 
      String city, 
      String state, 
      String countryCode, 
      String postalCode, 
      String latitude, 
      String longitude, 
      String timeCreated}){
    _id = id;
    _userId = userId;
    _userName = userName;
    _status = status;
    _recipientName = recipientName;
    _recipientPhone = recipientPhone;
    _recipientAltPhone = recipientAltPhone;
    _recipientEmail = recipientEmail;
    _address = address;
    _city = city;
    _state = state;
    _countryCode = countryCode;
    _postalCode = postalCode;
    _latitude = latitude;
    _longitude = longitude;
    _timeCreated = timeCreated;
}

  Address.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _userName = json["user_name"];
    _status = json["status"];
    _recipientName = json["recipient_name"];
    _recipientPhone = json["recipient_phone"];
    _recipientAltPhone = json["recipient_alt_phone"];
    _recipientEmail = json["recipient_email"];
    _address = json["address"];
    _city = json["city"];
    _state = json["state"];
    _countryCode = json["country_code"];
    _postalCode = json["postal_code"];
    _latitude = json["latitude"];
    _longitude = json["longitude"];
    _timeCreated = json["time_created"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["user_name"] = _userName;
    map["status"] = _status;
    map["recipient_name"] = _recipientName;
    map["recipient_phone"] = _recipientPhone;
    map["recipient_alt_phone"] = _recipientAltPhone;
    map["recipient_email"] = _recipientEmail;
    map["address"] = _address;
    map["city"] = _city;
    map["state"] = _state;
    map["country_code"] = _countryCode;
    map["postal_code"] = _postalCode;
    map["latitude"] = _latitude;
    map["longitude"] = _longitude;
    map["time_created"] = _timeCreated;
    return map;
  }

}