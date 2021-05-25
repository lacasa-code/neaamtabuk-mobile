/// status_code : 200
/// message : "success"
/// data : [{"id":9,"user_id":3,"product_id":47,"user_name":"firstuser","product_name":"first time","time_created":"2021-05-19 11:55:01"},{"id":10,"user_id":3,"product_id":1,"user_name":"firstuser","product_name":"first product","time_created":"2021-05-19 11:55:12"},{"id":11,"user_id":3,"product_id":19,"user_name":"firstuser","product_name":"zoom","time_created":"2021-05-19 11:55:17"},{"id":12,"user_id":3,"product_id":50,"user_name":"firstuser","product_name":"yoou","time_created":"2021-05-19 11:55:23"}]
/// total : 4

class Wishlist_model {
  int _statusCode;
  String _message;
  List<WishListItem> _data;
  int _total;

  int get statusCode => _statusCode;
  String get message => _message;
  List<WishListItem> get data => _data;
  int get total => _total;

  Wishlist_model({
      int statusCode, 
      String message, 
      List<WishListItem> data, 
      int total}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
    _total = total;
}

  Wishlist_model.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(WishListItem.fromJson(v));
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

/// id : 9
/// user_id : 3
/// product_id : 47
/// user_name : "firstuser"
/// product_name : "first time"
/// time_created : "2021-05-19 11:55:01"

class WishListItem {
  int _id;
  int _userId;
  int _productId;
  String _userName;
  String _productName;
  String _timeCreated;

  int get id => _id;
  int get userId => _userId;
  int get productId => _productId;
  String get userName => _userName;
  String get productName => _productName;
  String get timeCreated => _timeCreated;

  WishListItem({
      int id, 
      int userId, 
      int productId, 
      String userName, 
      String productName, 
      String timeCreated}){
    _id = id;
    _userId = userId;
    _productId = productId;
    _userName = userName;
    _productName = productName;
    _timeCreated = timeCreated;
}

  WishListItem.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _productId = json["product_id"];
    _userName = json["user_name"];
    _productName = json["product_name"];
    _timeCreated = json["time_created"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["product_id"] = _productId;
    map["user_name"] = _userName;
    map["product_name"] = _productName;
    map["time_created"] = _timeCreated;
    return map;
  }

}