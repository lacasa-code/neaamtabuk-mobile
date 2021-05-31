/// status_code : 200
/// message : "success"
/// data : [{"id":1,"payment_name":"online","status":1,"lang":"ar"},{"id":2,"payment_name":"cash on delivery","status":1,"lang":"ar"}]

class Payment_model {
  int _statusCode;
  String _message;
  List<Payment> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Payment> get data => _data;

  Payment_model({
      int statusCode, 
      String message, 
      List<Payment> data}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  Payment_model.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Payment.fromJson(v));
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
/// payment_name : "online"
/// status : 1
/// lang : "ar"

class Payment {
  int _id;
  String _paymentName;
  int _status;
  String _lang;

  int get id => _id;
  String get paymentName => _paymentName;
  int get status => _status;
  String get lang => _lang;

  Payment({
      int id, 
      String paymentName, 
      int status, 
      String lang}){
    _id = id;
    _paymentName = paymentName;
    _status = status;
    _lang = lang;
}

  Payment.fromJson(dynamic json) {
    _id = json["id"];
    _paymentName = json["payment_name"];
    _status = json["status"];
    _lang = json["lang"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["payment_name"] = _paymentName;
    map["status"] = _status;
    map["lang"] = _lang;
    return map;
  }

}