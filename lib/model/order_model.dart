/// status_code : 200
/// message : "success"
/// data : [{"id":26,"user_id":3,"paid":1,"approved":1,"expired":0,"status":1,"order_number":20000022,"order_total":"598777.00","sumTotal":598777,"orderStatus":"pending","order_details":[{"id":33,"order_id":26,"product_id":30,"store_id":2,"vendor_id":2,"quantity":1,"price":598777,"discount":0,"total":598777,"approved":1,"vendor_type":1,"part_category_id":1}]}]

class Order_model {
  int _statusCode;
  String _message;
  List<Order> _data;

  int get statusCode => _statusCode;
  String get message => _message;
  List<Order> get data => _data;

  Order_model({int statusCode, String message, List<Order> data}) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  Order_model.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Order.fromJson(v));
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

/// id : 26
/// user_id : 3
/// paid : 1
/// approved : 1
/// expired : 0
/// status : 1
/// order_number : 20000022
/// order_total : "598777.00"
/// sumTotal : 598777
/// orderStatus : "pending"
/// order_details : [{"id":33,"order_id":26,"product_id":30,"store_id":2,"vendor_id":2,"quantity":1,"price":598777,"discount":0,"total":598777,"approved":1,"vendor_type":1,"part_category_id":1}]

class Order {
  int _id;
  int _userId;
  int _paid;
  int _approved;
  int _expired;
  int _status;
  int _orderNumber;
  String _orderTotal;
  int _sumTotal;
  String _orderStatus;
  List<Order_details> _orderDetails;

  int get id => _id;
  int get userId => _userId;
  int get paid => _paid;
  int get approved => _approved;
  int get expired => _expired;
  int get status => _status;
  int get orderNumber => _orderNumber;
  String get orderTotal => _orderTotal;
  int get sumTotal => _sumTotal;
  String get orderStatus => _orderStatus;
  List<Order_details> get orderDetails => _orderDetails;

  Order(
      {int id,
      int userId,
      int paid,
      int approved,
      int expired,
      int status,
      int orderNumber,
      String orderTotal,
      int sumTotal,
      String orderStatus,
      List<Order_details> orderDetails}) {
    _id = id;
    _userId = userId;
    _paid = paid;
    _approved = approved;
    _expired = expired;
    _status = status;
    _orderNumber = orderNumber;
    _orderTotal = orderTotal;
    _sumTotal = sumTotal;
    _orderStatus = orderStatus;
    _orderDetails = orderDetails;
  }

  Order.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _paid = json["paid"];
    _approved = json["approved"];
    _expired = json["expired"];
    _status = json["status"];
    _orderNumber = json["order_number"];
    _orderTotal = json["order_total"];
    _sumTotal = json["sumTotal"];
    _orderStatus = json["orderStatus"];
    if (json["order_details"] != null) {
      _orderDetails = [];
      json["order_details"].forEach((v) {
        _orderDetails.add(Order_details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["paid"] = _paid;
    map["approved"] = _approved;
    map["expired"] = _expired;
    map["status"] = _status;
    map["order_number"] = _orderNumber;
    map["order_total"] = _orderTotal;
    map["sumTotal"] = _sumTotal;
    map["orderStatus"] = _orderStatus;
    if (_orderDetails != null) {
      map["order_details"] = _orderDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 33
/// order_id : 26
/// product_id : 30
/// store_id : 2
/// vendor_id : 2
/// quantity : 1
/// price : 598777
/// discount : 0
/// total : 598777
/// approved : 1
/// vendor_type : 1
/// part_category_id : 1

class Order_details {
  int _id;
  int _orderId;
  int _productId;
  int _storeId;
  int _vendorId;
  int _quantity;
  int _price;
  int _discount;
  int _total;
  int _approved;
  int _vendorType;
  int _partCategoryId;

  int get id => _id;
  int get orderId => _orderId;
  int get productId => _productId;
  int get storeId => _storeId;
  int get vendorId => _vendorId;
  int get quantity => _quantity;
  int get price => _price;
  int get discount => _discount;
  int get total => _total;
  int get approved => _approved;
  int get vendorType => _vendorType;
  int get partCategoryId => _partCategoryId;

  Order_details(
      {int id,
      int orderId,
      int productId,
      int storeId,
      int vendorId,
      int quantity,
      int price,
      int discount,
      int total,
      int approved,
      int vendorType,
      int partCategoryId}) {
    _id = id;
    _orderId = orderId;
    _productId = productId;
    _storeId = storeId;
    _vendorId = vendorId;
    _quantity = quantity;
    _price = price;
    _discount = discount;
    _total = total;
    _approved = approved;
    _vendorType = vendorType;
    _partCategoryId = partCategoryId;
  }

  Order_details.fromJson(dynamic json) {
    _id = json["id"];
    _orderId = json["order_id"];
    _productId = json["product_id"];
    _storeId = json["store_id"];
    _vendorId = json["vendor_id"];
    _quantity = json["quantity"];
    _price = json["price"];
    _discount = json["discount"];
    _total = json["total"];
    _approved = json["approved"];
    _vendorType = json["vendor_type"];
    _partCategoryId = json["part_category_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["order_id"] = _orderId;
    map["product_id"] = _productId;
    map["store_id"] = _storeId;
    map["vendor_id"] = _vendorId;
    map["quantity"] = _quantity;
    map["price"] = _price;
    map["discount"] = _discount;
    map["total"] = _total;
    map["approved"] = _approved;
    map["vendor_type"] = _vendorType;
    map["part_category_id"] = _partCategoryId;
    return map;
  }
}
