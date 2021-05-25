/// status_code : 200
/// message : "success"
/// data : {"name":"firstuser","email":"firstuser@user.com","wishlists_count":4,"history_count":18,"user_shippings":[{"id":1,"user_id":3,"recipient_name":"first user","recipient_phone":"966507777777","recipient_alt_phone":null,"recipient_email":"firstuser@user.com","address":"first user address","city":"first user city","state":"saudi","country_code":"sa","postal_code":"000","latitude":"40.11111","longitude":"40.1111","status":1,"lang":"ar"}],"payment_method":"online","last_transaction_time":"2021-05-19 11:56:05"}

class UserInformation {
  int _statusCode;
  String _message;
  User _data;

  int get statusCode => _statusCode;
  String get message => _message;
  User get data => _data;

  UserInformation({
      int statusCode, 
      String message, 
      User data}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  UserInformation.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    _data = json["data"] != null ? User.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// name : "firstuser"
/// email : "firstuser@user.com"
/// wishlists_count : 4
/// history_count : 18
/// user_shippings : [{"id":1,"user_id":3,"recipient_name":"first user","recipient_phone":"966507777777","recipient_alt_phone":null,"recipient_email":"firstuser@user.com","address":"first user address","city":"first user city","state":"saudi","country_code":"sa","postal_code":"000","latitude":"40.11111","longitude":"40.1111","status":1,"lang":"ar"}]
/// payment_method : "online"
/// last_transaction_time : "2021-05-19 11:56:05"

class User {
  String _name;
  String _email;
  int _wishlistsCount;
  int _historyCount;
  List<User_shippings> _userShippings;
  String _paymentMethod;
  String _lastTransactionTime;

  String get name => _name;
  String get email => _email;
  int get wishlistsCount => _wishlistsCount;
  int get historyCount => _historyCount;
  List<User_shippings> get userShippings => _userShippings;
  String get paymentMethod => _paymentMethod;
  String get lastTransactionTime => _lastTransactionTime;

  User({
      String name, 
      String email, 
      int wishlistsCount, 
      int historyCount, 
      List<User_shippings> userShippings, 
      String paymentMethod, 
      String lastTransactionTime}){
    _name = name;
    _email = email;
    _wishlistsCount = wishlistsCount;
    _historyCount = historyCount;
    _userShippings = userShippings;
    _paymentMethod = paymentMethod;
    _lastTransactionTime = lastTransactionTime;
}

  User.fromJson(dynamic json) {
    _name = json["name"];
    _email = json["email"];
    _wishlistsCount = json["wishlists_count"];
    _historyCount = json["history_count"];
    if (json["user_shippings"] != null) {
      _userShippings = [];
      json["user_shippings"].forEach((v) {
        _userShippings.add(User_shippings.fromJson(v));
      });
    }
    _paymentMethod = json["payment_method"];
    _lastTransactionTime = json["last_transaction_time"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["email"] = _email;
    map["wishlists_count"] = _wishlistsCount;
    map["history_count"] = _historyCount;
    if (_userShippings != null) {
      map["user_shippings"] = _userShippings.map((v) => v.toJson()).toList();
    }
    map["payment_method"] = _paymentMethod;
    map["last_transaction_time"] = _lastTransactionTime;
    return map;
  }

}

/// id : 1
/// user_id : 3
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
/// status : 1
/// lang : "ar"

class User_shippings {
  int _id;
  int _userId;
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
  int _status;
  String _lang;

  int get id => _id;
  int get userId => _userId;
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
  int get status => _status;
  String get lang => _lang;

  User_shippings({
      int id, 
      int userId, 
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
      int status, 
      String lang}){
    _id = id;
    _userId = userId;
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
    _status = status;
    _lang = lang;
}

  User_shippings.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
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
    _status = json["status"];
    _lang = json["lang"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
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
    map["status"] = _status;
    map["lang"] = _lang;
    return map;
  }

}