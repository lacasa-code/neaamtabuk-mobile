import 'package:flutter_pos/model/payment_model.dart';
import 'package:flutter_pos/model/shipping_address.dart';

/// status_code : 200
/// data : {"id":41,"user_id":3,"user_name":"firstuser","order_number":20000037,"order_total":"9.30","expired":0,"approved":null,"paid":null,"shipping":null,"payment":{"id":2,"payment_name":"cash on delivery","status":1,"created_at":"2021-04-15T11:14:19.000000Z","updated_at":null,"deleted_at":null,"lang":"ar"},"status":1,"created_at":"2021-06-01 07:42:15","orderStatus":"pending","orderDetails":[{"id":72,"order_id":41,"product_id":1,"store_id":2,"vendor_id":1,"product_name":"first product","product_image":[{"id":120,"model_type":"App\\Models\\Product","model_id":1,"uuid":"7168e2b9-6f1d-4430-866e-364789c3641d","collection_name":"photo","name":"giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu","file_name":"giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","mime_type":"image/png","disk":"public","conversions_disk":"public","size":26146,"manipulations":[],"custom_properties":{"generated_conversions":{"thumb":true,"preview":true}},"responsive_images":[],"order_column":116,"created_at":"2021-05-31T09:00:14.000000Z","updated_at":"2021-05-31T09:00:14.000000Z","image":"https://traker.fra1.digitaloceanspaces.com/products/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","url":"https://development.lacasacode.dev/storage/120/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","fullurl":"https://development.lacasacode.dev/storage/120/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","thumbnail":"https://development.lacasacode.dev/storage/120/conversions/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu-thumb.jpg","preview":"https://development.lacasacode.dev/storage/120/conversions/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu-preview.jpg"}],"product_serial":"DEDXYLizcO","store_name":"updated store h","vendor_name":"first vendor","quantity":1,"price":9.3,"discount":7,"total":9.3,"approved":0,"created_at":"2021-06-01 07:42:15"}]}
/// cart_total : 1
/// message : "success checkout"

class Checkout_model {
  int _statusCode;
  Data _data;
  int _cartTotal;
  String _message;

  int get statusCode => _statusCode;
  Data get data => _data;
  int get cartTotal => _cartTotal;
  String get message => _message;

  Checkout_model({
      int statusCode, 
      Data data, 
      int cartTotal, 
      String message}){
    _statusCode = statusCode;
    _data = data;
    _cartTotal = cartTotal;
    _message = message;
}

  Checkout_model.fromJson(dynamic json) {
    _statusCode = json["status_code"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _cartTotal = json["cart_total"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status_code"] = _statusCode;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    map["cart_total"] = _cartTotal;
    map["message"] = _message;
    return map;
  }

}

/// id : 41
/// user_id : 3
/// user_name : "firstuser"
/// order_number : 20000037
/// order_total : "9.30"
/// expired : 0
/// approved : null
/// paid : null
/// shipping : null
/// payment : {"id":2,"payment_name":"cash on delivery","status":1,"created_at":"2021-04-15T11:14:19.000000Z","updated_at":null,"deleted_at":null,"lang":"ar"}
/// status : 1
/// created_at : "2021-06-01 07:42:15"
/// orderStatus : "pending"
/// orderDetails : [{"id":72,"order_id":41,"product_id":1,"store_id":2,"vendor_id":1,"product_name":"first product","product_image":[{"id":120,"model_type":"App\\Models\\Product","model_id":1,"uuid":"7168e2b9-6f1d-4430-866e-364789c3641d","collection_name":"photo","name":"giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu","file_name":"giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","mime_type":"image/png","disk":"public","conversions_disk":"public","size":26146,"manipulations":[],"custom_properties":{"generated_conversions":{"thumb":true,"preview":true}},"responsive_images":[],"order_column":116,"created_at":"2021-05-31T09:00:14.000000Z","updated_at":"2021-05-31T09:00:14.000000Z","image":"https://traker.fra1.digitaloceanspaces.com/products/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","url":"https://development.lacasacode.dev/storage/120/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","fullurl":"https://development.lacasacode.dev/storage/120/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","thumbnail":"https://development.lacasacode.dev/storage/120/conversions/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu-thumb.jpg","preview":"https://development.lacasacode.dev/storage/120/conversions/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu-preview.jpg"}],"product_serial":"DEDXYLizcO","store_name":"updated store h","vendor_name":"first vendor","quantity":1,"price":9.3,"discount":7,"total":9.3,"approved":0,"created_at":"2021-06-01 07:42:15"}]

class Data {
  int _id;
  int _userId;
  String _userName;
  int _orderNumber;
  String _orderTotal;
  int _expired;
  dynamic _approved;
  dynamic _paid;
  Address _shipping;
  Payment _payment;
  String _status;
  String _createdAt;
  String _orderStatus;
  List<OrderDetails> _orderDetails;

  int get id => _id;
  int get userId => _userId;
  String get userName => _userName;
  int get orderNumber => _orderNumber;
  String get orderTotal => _orderTotal;
  int get expired => _expired;
  dynamic get approved => _approved;
  dynamic get paid => _paid;
  Address get shipping => _shipping;
  Payment get payment => _payment;
  String get status => _status;
  String get createdAt => _createdAt;
  String get orderStatus => _orderStatus;
  List<OrderDetails> get orderDetails => _orderDetails;

  Data({
      int id, 
      int userId, 
      String userName, 
      int orderNumber, 
      String orderTotal, 
      int expired, 
      dynamic approved, 
      dynamic paid,
    Address shipping,
      Payment payment,
    String status,
      String createdAt, 
      String orderStatus, 
      List<OrderDetails> orderDetails}){
    _id = id;
    _userId = userId;
    _userName = userName;
    _orderNumber = orderNumber;
    _orderTotal = orderTotal;
    _expired = expired;
    _approved = approved;
    _paid = paid;
    _shipping = shipping;
    _payment = payment;
    _status = status;
    _createdAt = createdAt;
    _orderStatus = orderStatus;
    _orderDetails = orderDetails;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _userName = json["user_name"];
    _orderNumber = json["order_number"];
    _orderTotal = json["order_total"];
    _expired = json["expired"];
    _approved = json["approved"];
    _paid = json["paid"];
    _shipping = json["shipping"] != null ? Address.fromJson(json["shipping"]) : null;
    _payment = json["payment"] != null ? Payment.fromJson(json["payment"]) : null;
    _status = json["status"];
    _createdAt = json["created_at"];
    _orderStatus = json["orderStatus"];
    if (json["orderDetails"] != null) {
      _orderDetails = [];
      json["orderDetails"].forEach((v) {
        _orderDetails.add(OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["user_name"] = _userName;
    map["order_number"] = _orderNumber;
    map["order_total"] = _orderTotal;
    map["expired"] = _expired;
    map["approved"] = _approved;
    map["paid"] = _paid;
    map["shipping"] = _shipping;
    if (_payment != null) {
      map["payment"] = _payment.toJson();
    }
    map["status"] = _status;
    map["created_at"] = _createdAt;
    map["orderStatus"] = _orderStatus;
    if (_orderDetails != null) {
      map["orderDetails"] = _orderDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 72
/// order_id : 41
/// product_id : 1
/// store_id : 2
/// vendor_id : 1
/// product_name : "first product"
/// product_image : [{"id":120,"model_type":"App\\Models\\Product","model_id":1,"uuid":"7168e2b9-6f1d-4430-866e-364789c3641d","collection_name":"photo","name":"giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu","file_name":"giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","mime_type":"image/png","disk":"public","conversions_disk":"public","size":26146,"manipulations":[],"custom_properties":{"generated_conversions":{"thumb":true,"preview":true}},"responsive_images":[],"order_column":116,"created_at":"2021-05-31T09:00:14.000000Z","updated_at":"2021-05-31T09:00:14.000000Z","image":"https://traker.fra1.digitaloceanspaces.com/products/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","url":"https://development.lacasacode.dev/storage/120/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","fullurl":"https://development.lacasacode.dev/storage/120/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png","thumbnail":"https://development.lacasacode.dev/storage/120/conversions/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu-thumb.jpg","preview":"https://development.lacasacode.dev/storage/120/conversions/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu-preview.jpg"}]
/// product_serial : "DEDXYLizcO"
/// store_name : "updated store h"
/// vendor_name : "first vendor"
/// quantity : 1
/// price : 9.3
/// discount : 7
/// total : 9.3
/// approved : 0
/// created_at : "2021-06-01 07:42:15"

class OrderDetails {
  int _id;
  int _orderId;
  int _productId;
  int _storeId;
  int _vendorId;
  String _productName;
  List<Product_image> _productImage;
  String _productSerial;
  String _storeName;
  String _vendorName;
  int _quantity;
  String _price;
  int _discount;
  String _total;
  int _approved;
  String _createdAt;

  int get id => _id;
  int get orderId => _orderId;
  int get productId => _productId;
  int get storeId => _storeId;
  int get vendorId => _vendorId;
  String get productName => _productName;
  List<Product_image> get productImage => _productImage;
  String get productSerial => _productSerial;
  String get storeName => _storeName;
  String get vendorName => _vendorName;
  int get quantity => _quantity;
  String get price => _price;
  int get discount => _discount;
  String get total => _total;
  int get approved => _approved;
  String get createdAt => _createdAt;

  OrderDetails({
      int id, 
      int orderId, 
      int productId, 
      int storeId, 
      int vendorId, 
      String productName, 
      List<Product_image> productImage, 
      String productSerial, 
      String storeName, 
      String vendorName, 
      int quantity,
    String price,
      int discount,
    String total,
      int approved, 
      String createdAt}){
    _id = id;
    _orderId = orderId;
    _productId = productId;
    _storeId = storeId;
    _vendorId = vendorId;
    _productName = productName;
    _productImage = productImage;
    _productSerial = productSerial;
    _storeName = storeName;
    _vendorName = vendorName;
    _quantity = quantity;
    _price = price;
    _discount = discount;
    _total = total;
    _approved = approved;
    _createdAt = createdAt;
}

  OrderDetails.fromJson(dynamic json) {
    _id = json["id"];
    _orderId = json["order_id"];
    _productId = json["product_id"];
    _storeId = json["store_id"];
    _vendorId = json["vendor_id"];
    _productName = json["product_name"];
    if (json["product_image"] != null) {
      _productImage = [];
      json["product_image"].forEach((v) {
        _productImage.add(Product_image.fromJson(v));
      });
    }
    _productSerial = json["product_serial"];
    _storeName = json["store_name"];
    _vendorName = json["vendor_name"];
    _quantity = json["quantity"];
    _price = json["price"].toString();
    _discount = json["discount"];
    _total = json["total"].toString();
    _approved = json["approved"];
    _createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["order_id"] = _orderId;
    map["product_id"] = _productId;
    map["store_id"] = _storeId;
    map["vendor_id"] = _vendorId;
    map["product_name"] = _productName;
    if (_productImage != null) {
      map["product_image"] = _productImage.map((v) => v.toJson()).toList();
    }
    map["product_serial"] = _productSerial;
    map["store_name"] = _storeName;
    map["vendor_name"] = _vendorName;
    map["quantity"] = _quantity;
    map["price"] = _price;
    map["discount"] = _discount;
    map["total"] = _total;
    map["approved"] = _approved;
    map["created_at"] = _createdAt;
    return map;
  }

}

/// id : 120
/// model_type : "App\\Models\\Product"
/// model_id : 1
/// uuid : "7168e2b9-6f1d-4430-866e-364789c3641d"
/// collection_name : "photo"
/// name : "giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu"
/// file_name : "giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png"
/// mime_type : "image/png"
/// disk : "public"
/// conversions_disk : "public"
/// size : 26146
/// manipulations : []
/// custom_properties : {"generated_conversions":{"thumb":true,"preview":true}}
/// responsive_images : []
/// order_column : 116
/// created_at : "2021-05-31T09:00:14.000000Z"
/// updated_at : "2021-05-31T09:00:14.000000Z"
/// image : "https://traker.fra1.digitaloceanspaces.com/products/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png"
/// url : "https://development.lacasacode.dev/storage/120/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png"
/// fullurl : "https://development.lacasacode.dev/storage/120/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu.png"
/// thumbnail : "https://development.lacasacode.dev/storage/120/conversions/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu-thumb.jpg"
/// preview : "https://development.lacasacode.dev/storage/120/conversions/giBvGNSBKNi2rTMXSWgP6ZhteEiaQzPzWWBrSEzu-preview.jpg"

class Product_image {
  int _id;
  String _modelType;
  int _modelId;
  String _uuid;
  String _collectionName;
  String _name;
  String _fileName;
  String _mimeType;
  String _disk;
  String _conversionsDisk;
  int _size;
  List<dynamic> _manipulations;
  Custom_properties _customProperties;
  List<dynamic> _responsiveImages;
  int _orderColumn;
  String _createdAt;
  String _updatedAt;
  String _image;
  String _url;
  String _fullurl;
  String _thumbnail;
  String _preview;

  int get id => _id;
  String get modelType => _modelType;
  int get modelId => _modelId;
  String get uuid => _uuid;
  String get collectionName => _collectionName;
  String get name => _name;
  String get fileName => _fileName;
  String get mimeType => _mimeType;
  String get disk => _disk;
  String get conversionsDisk => _conversionsDisk;
  int get size => _size;
  List<dynamic> get manipulations => _manipulations;
  Custom_properties get customProperties => _customProperties;
  List<dynamic> get responsiveImages => _responsiveImages;
  int get orderColumn => _orderColumn;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get image => _image;
  String get url => _url;
  String get fullurl => _fullurl;
  String get thumbnail => _thumbnail;
  String get preview => _preview;

  Product_image({
      int id, 
      String modelType, 
      int modelId, 
      String uuid, 
      String collectionName, 
      String name, 
      String fileName, 
      String mimeType, 
      String disk, 
      String conversionsDisk, 
      int size, 
      List<dynamic> manipulations, 
      Custom_properties customProperties, 
      List<dynamic> responsiveImages, 
      int orderColumn, 
      String createdAt, 
      String updatedAt, 
      String image, 
      String url, 
      String fullurl, 
      String thumbnail, 
      String preview}){
    _id = id;
    _modelType = modelType;
    _modelId = modelId;
    _uuid = uuid;
    _collectionName = collectionName;
    _name = name;
    _fileName = fileName;
    _mimeType = mimeType;
    _disk = disk;
    _conversionsDisk = conversionsDisk;
    _size = size;
    _manipulations = manipulations;
    _customProperties = customProperties;
    _responsiveImages = responsiveImages;
    _orderColumn = orderColumn;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _image = image;
    _url = url;
    _fullurl = fullurl;
    _thumbnail = thumbnail;
    _preview = preview;
}

  Product_image.fromJson(dynamic json) {
    _id = json["id"];
    _modelType = json["model_type"];
    _modelId = json["model_id"];
    _uuid = json["uuid"];
    _collectionName = json["collection_name"];
    _name = json["name"];
    _fileName = json["file_name"];
    _mimeType = json["mime_type"];
    _disk = json["disk"];
    _conversionsDisk = json["conversions_disk"];
    _size = json["size"];
    _orderColumn = json["order_column"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _image = json["image"];
    _url = json["url"];
    _fullurl = json["fullurl"];
    _thumbnail = json["thumbnail"];
    _preview = json["preview"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["model_type"] = _modelType;
    map["model_id"] = _modelId;
    map["uuid"] = _uuid;
    map["collection_name"] = _collectionName;
    map["name"] = _name;
    map["file_name"] = _fileName;
    map["mime_type"] = _mimeType;
    map["disk"] = _disk;
    map["conversions_disk"] = _conversionsDisk;
    map["size"] = _size;
    if (_manipulations != null) {
      map["manipulations"] = _manipulations.map((v) => v.toJson()).toList();
    }
    if (_customProperties != null) {
      map["custom_properties"] = _customProperties.toJson();
    }
    if (_responsiveImages != null) {
      map["responsive_images"] = _responsiveImages.map((v) => v.toJson()).toList();
    }
    map["order_column"] = _orderColumn;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["image"] = _image;
    map["url"] = _url;
    map["fullurl"] = _fullurl;
    map["thumbnail"] = _thumbnail;
    map["preview"] = _preview;
    return map;
  }

}

/// generated_conversions : {"thumb":true,"preview":true}

class Custom_properties {
  Generated_conversions _generatedConversions;

  Generated_conversions get generatedConversions => _generatedConversions;

  Custom_properties({
      Generated_conversions generatedConversions}){
    _generatedConversions = generatedConversions;
}

  Custom_properties.fromJson(dynamic json) {
    _generatedConversions = json["generated_conversions"] != null ? Generated_conversions.fromJson(json["generatedConversions"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_generatedConversions != null) {
      map["generated_conversions"] = _generatedConversions.toJson();
    }
    return map;
  }

}

/// thumb : true
/// preview : true

class Generated_conversions {
  bool _thumb;
  bool _preview;

  bool get thumb => _thumb;
  bool get preview => _preview;

  Generated_conversions({
      bool thumb, 
      bool preview}){
    _thumb = thumb;
    _preview = preview;
}

  Generated_conversions.fromJson(dynamic json) {
    _thumb = json["thumb"];
    _preview = json["preview"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["thumb"] = _thumb;
    map["preview"] = _preview;
    return map;
  }

}

/// id : 2
/// payment_name : "cash on delivery"
/// status : 1
/// created_at : "2021-04-15T11:14:19.000000Z"
/// updated_at : null
/// deleted_at : null
/// lang : "ar"

