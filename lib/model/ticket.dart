/// status_code : 200
/// message : "success"
/// data : [{"id":11,"ticket_no":"6UZYXC8PEZ","title":"شكوى","priority":"medium","message":"رساله تتضمن شكوى","status":"open","category_id":1,"category_name":"technical","user_id":2,"user_name":"Trkar2Ahmed","vendor_id":54,"vendor_name":"Ahmed","order_id":43,"attachment":{"id":707,"model_id":11,"uuid":"b6d6c6ef-20c9-4bc1-a7cf-e1893e92140e","image":"https://traker.fra1.digitaloceanspaces.com/tickets/attachments/OF03PhSLK3we5RhpDmumYyxlde3k8vM74iZqklPF.png"},"answer":null,"comments":[],"case":"to admin","reply":"no reply yet","orderDetails":[],"order_number":20000042,"order_created_at":"2021-06-27 14:52:06","vendor_email":"ahmed.mohamed@lacasacode.com","created_at":"2021-06-28 11:25:03"}]

class Ticket_model {
  int _statusCode;
  String _message;
  List<Ticket> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Ticket> get data => _data;

  Ticket_model({
      int statusCode, 
      String message, 
      List<Ticket> data}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  Ticket_model.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Ticket.fromJson(v));
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

/// id : 11
/// ticket_no : "6UZYXC8PEZ"
/// title : "شكوى"
/// priority : "medium"
/// message : "رساله تتضمن شكوى"
/// status : "open"
/// category_id : 1
/// category_name : "technical"
/// user_id : 2
/// user_name : "Trkar2Ahmed"
/// vendor_id : 54
/// vendor_name : "Ahmed"
/// order_id : 43
/// attachment : {"id":707,"model_id":11,"uuid":"b6d6c6ef-20c9-4bc1-a7cf-e1893e92140e","image":"https://traker.fra1.digitaloceanspaces.com/tickets/attachments/OF03PhSLK3we5RhpDmumYyxlde3k8vM74iZqklPF.png"}
/// answer : null
/// comments : []
/// case : "to admin"
/// reply : "no reply yet"
/// orderDetails : []
/// order_number : 20000042
/// order_created_at : "2021-06-27 14:52:06"
/// vendor_email : "ahmed.mohamed@lacasacode.com"
/// created_at : "2021-06-28 11:25:03"

class Ticket {
  int _id;
  String _ticketNo;
  String _title;
  String _priority;
  String _message;
  String _status;
  int _categoryId;
  String _categoryName;
  int _userId;
  String _userName;
  int _vendorId;
  String _vendorName;
  int _orderId;
  Attachment _attachment;
  dynamic _answer;
  List<dynamic> _comments;
  String _case;
  String _reply;
  List<dynamic> _orderDetails;
  int _orderNumber;
  String _orderCreatedAt;
  String _vendorEmail;
  String _createdAt;

  int get id => _id;
  String get ticketNo => _ticketNo;
  String get title => _title;
  String get priority => _priority;
  String get message => _message;
  String get status => _status;
  int get categoryId => _categoryId;
  String get categoryName => _categoryName;
  int get userId => _userId;
  String get userName => _userName;
  int get vendorId => _vendorId;
  String get vendorName => _vendorName;
  int get orderId => _orderId;
  Attachment get attachment => _attachment;
  dynamic get answer => _answer;
  List<dynamic> get comments => _comments;
  String get Case => _case;
  String get reply => _reply;
  List<dynamic> get orderDetails => _orderDetails;
  int get orderNumber => _orderNumber;
  String get orderCreatedAt => _orderCreatedAt;
  String get vendorEmail => _vendorEmail;
  String get createdAt => _createdAt;

  Ticket({
      int id, 
      String ticketNo, 
      String title, 
      String priority, 
      String message, 
      String status, 
      int categoryId, 
      String categoryName, 
      int userId, 
      String userName, 
      int vendorId, 
      String vendorName, 
      int orderId, 
      Attachment attachment, 
      dynamic answer, 
      List<dynamic> comments, 
      //String case,
      String reply, 
      List<dynamic> orderDetails, 
      int orderNumber, 
      String orderCreatedAt, 
      String vendorEmail, 
      String createdAt}){
    _id = id;
    _ticketNo = ticketNo;
    _title = title;
    _priority = priority;
    _message = message;
    _status = status;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _userId = userId;
    _userName = userName;
    _vendorId = vendorId;
    _vendorName = vendorName;
    _orderId = orderId;
    _attachment = attachment;
    _answer = answer;
    _comments = comments;
    //_case = case;
    _reply = reply;
    _orderDetails = orderDetails;
    _orderNumber = orderNumber;
    _orderCreatedAt = orderCreatedAt;
    _vendorEmail = vendorEmail;
    _createdAt = createdAt;
}

  Ticket.fromJson(dynamic json) {
    _id = json["id"];
    _ticketNo = json["ticket_no"];
    _title = json["title"];
    _priority = json["priority"];
    _message = json["message"];
    _status = json["status"];
    _categoryId = json["category_id"];
    _categoryName = json["category_name"];
    _userId = json["user_id"];
    _userName = json["user_name"];
    _vendorId = json["vendor_id"];
    _vendorName = json["vendor_name"];
    _orderId = json["order_id"];
    _attachment = json["attachment"] != null ? Attachment.fromJson(json["attachment"]) : null;
    _answer = json["answer"];
    if (json["comments"] != null) {
      _comments = [];
      json["comments"].forEach((v) {
       // _comments.add(dynamic.fromJson(v));
      });
    }
    _case = json["case"];

    _reply = json["reply"];
    if (json["orderDetails"] != null) {
      _orderDetails = [];
      json["orderDetails"].forEach((v) {
       // _orderDetails.add(dynamic.fromJson(v));
      });
    }
    _orderNumber = json["order_number"];
    _orderCreatedAt = json["order_created_at"];
    _vendorEmail = json["vendor_email"];
    _createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["ticket_no"] = _ticketNo;
    map["title"] = _title;
    map["priority"] = _priority;
    map["message"] = _message;
    map["status"] = _status;
    map["category_id"] = _categoryId;
    map["category_name"] = _categoryName;
    map["user_id"] = _userId;
    map["user_name"] = _userName;
    map["vendor_id"] = _vendorId;
    map["vendor_name"] = _vendorName;
    map["order_id"] = _orderId;
    if (_attachment != null) {
      map["attachment"] = _attachment.toJson();
    }
    map["answer"] = _answer;
    if (_comments != null) {
      map["comments"] = _comments.map((v) => v.toJson()).toList();
    }
    map["case"] = _case;
    map["reply"] = _reply;
    if (_orderDetails != null) {
      map["orderDetails"] = _orderDetails.map((v) => v.toJson()).toList();
    }
    map["order_number"] = _orderNumber;
    map["order_created_at"] = _orderCreatedAt;
    map["vendor_email"] = _vendorEmail;
    map["created_at"] = _createdAt;
    return map;
  }

}

/// id : 707
/// model_id : 11
/// uuid : "b6d6c6ef-20c9-4bc1-a7cf-e1893e92140e"
/// image : "https://traker.fra1.digitaloceanspaces.com/tickets/attachments/OF03PhSLK3we5RhpDmumYyxlde3k8vM74iZqklPF.png"

class Attachment {
  int _id;
  int _modelId;
  String _uuid;
  String _image;

  int get id => _id;
  int get modelId => _modelId;
  String get uuid => _uuid;
  String get image => _image;

  Attachment({
      int id, 
      int modelId, 
      String uuid, 
      String image}){
    _id = id;
    _modelId = modelId;
    _uuid = uuid;
    _image = image;
}

  Attachment.fromJson(dynamic json) {
    _id = json["id"];
    _modelId = json["model_id"];
    _uuid = json["uuid"];
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["model_id"] = _modelId;
    map["uuid"] = _uuid;
    map["image"] = _image;
    return map;
  }

}