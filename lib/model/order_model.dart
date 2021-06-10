class Order_model {
  int statusCode;
  String message;
  List<Order> data;

  Order_model({this.statusCode, this.message, this.data});

  Order_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Order>();
      json['data'].forEach((v) {
        data.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int id;
  int userId;
  String userName;
  int orderNumber;
  String orderTotal;
  int expired;
  Null approved;
  int paid;
  int status;
  String createdAt;
  String orderStatus;
  List<OrderDetails> orderDetails;

  Order(
      {this.id,
        this.userId,
        this.userName,
        this.orderNumber,
        this.orderTotal,
        this.expired,
        this.approved,
        this.paid,
        this.status,
        this.createdAt,
        this.orderStatus,
        this.orderDetails});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    orderNumber = json['order_number'];
    orderTotal = json['order_total'];
    expired = json['expired'];
    //approved = json['approved'];
    paid = json['paid'];
    status = json['status'];
    createdAt = json['created_at'];
    orderStatus = json['orderStatus'];
    if (json['orderDetails'] != null) {
      orderDetails = new List<OrderDetails>();
      json['orderDetails'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['order_number'] = this.orderNumber;
    data['order_total'] = this.orderTotal;
    data['expired'] = this.expired;
    data['approved'] = this.approved;
    data['paid'] = this.paid;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['orderStatus'] = this.orderStatus;
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  int id;
  int orderId;
  int productId;
  int storeId;
  int vendorId;
  String productName;
  List<ProductImage> productImage;
  String productSerial;
  String storeName;
  String vendorName;
  int quantity;
  String price;
  int discount;
  String total;
  int approved;
  String createdAt;

  OrderDetails(
      {this.id,
        this.orderId,
        this.productId,
        this.storeId,
        this.vendorId,
        this.productName,
        this.productImage,
        this.productSerial,
        this.storeName,
        this.vendorName,
        this.quantity,
        this.price,
        this.discount,
        this.total,
        this.approved,
        this.createdAt});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    storeId = json['store_id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    if (json['product_image'] != null) {
      productImage = new List<ProductImage>();
      json['product_image'].forEach((v) {
        productImage.add(new ProductImage.fromJson(v));
      });
    }
    productSerial = json['product_serial'];
    storeName = json['store_name'];
    vendorName = json['vendor_name'];
    quantity = json['quantity'];
    price = json['price'].toString();
    discount = json['discount'];
    total = json['total'].toString();
    approved = json['approved'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['store_id'] = this.storeId;
    data['vendor_id'] = this.vendorId;
    data['product_name'] = this.productName;
    if (this.productImage != null) {
      data['product_image'] = this.productImage.map((v) => v.toJson()).toList();
    }
    data['product_serial'] = this.productSerial;
    data['store_name'] = this.storeName;
    data['vendor_name'] = this.vendorName;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['total'] = this.total;
    data['approved'] = this.approved;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ProductImage {
  int id;
  String modelType;
  int modelId;
  String uuid;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String conversionsDisk;
  int size;
  List<Null> manipulations;
  CustomProperties customProperties;
  List<Null> responsiveImages;
  int orderColumn;
  String createdAt;
  String updatedAt;
  String image;
  String url;
  String fullurl;
  String thumbnail;
  String preview;

  ProductImage(
      {this.id,
        this.modelType,
        this.modelId,
        this.uuid,
        this.collectionName,
        this.name,
        this.fileName,
        this.mimeType,
        this.disk,
        this.conversionsDisk,
        this.size,
        this.manipulations,
        this.customProperties,
        this.responsiveImages,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.url,
        this.fullurl,
        this.thumbnail,
        this.preview});

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    url = json['url'];
    fullurl = json['fullurl'];
    thumbnail = json['thumbnail'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['uuid'] = this.uuid;
    data['collection_name'] = this.collectionName;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['mime_type'] = this.mimeType;
    data['disk'] = this.disk;
    data['conversions_disk'] = this.conversionsDisk;
    data['size'] = this.size;


    data['order_column'] = this.orderColumn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['url'] = this.url;
    data['fullurl'] = this.fullurl;
    data['thumbnail'] = this.thumbnail;
    data['preview'] = this.preview;
    return data;
  }
}

class CustomProperties {
  GeneratedConversions generatedConversions;

  CustomProperties({this.generatedConversions});

  CustomProperties.fromJson(Map<String, dynamic> json) {
    generatedConversions = json['generated_conversions'] != null
        ? new GeneratedConversions.fromJson(json['generated_conversions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generatedConversions != null) {
      data['generated_conversions'] = this.generatedConversions.toJson();
    }
    return data;
  }
}

class GeneratedConversions {
  bool thumb;
  bool preview;

  GeneratedConversions({this.thumb, this.preview});

  GeneratedConversions.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['preview'] = this.preview;
    return data;
  }
}
