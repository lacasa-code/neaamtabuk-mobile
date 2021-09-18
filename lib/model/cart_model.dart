class Cart_model {
  int statusCode;
  Cart data;
  int cartTotal;
  String message;
  bool mixed;

  Cart_model({this.statusCode, this.data, this.cartTotal, this.message});

  Cart_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = Cart.fromJson(json['data']);
    }
    cartTotal = json['cart_total'];
    message = json['message'];
    mixed = json['mixed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;

    data['cart_total'] = this.cartTotal;
    data['message'] = this.message;
    data['mixed'] = this.mixed;
    return data;
  }
}

class Cart {
  int id;
  int userId;
  String userName;
  int orderNumber;
  String orderTotal;
  int count_pieces;
  int expired;
  String paid;
  String status;
  String orderStatus;
  List<OrderDetails> orderDetails;

  Cart(
      {this.id,
        this.userId,
        this.userName,
        this.orderNumber,
        this.orderTotal,
        this.expired,
        this.paid,
        this.status,
        this.count_pieces,
        this.orderStatus,
        this.orderDetails});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    orderNumber = json['order_number'];
    orderTotal = json['order_total'];
    expired = json['expired'];
    paid = json['paid'];
    status = json['status'];
    count_pieces = json['count_pieces'];
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
    data['paid'] = this.paid;
    data['status'] = this.status;
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
  String actual_price;
  String discount;
  String total;
  int approved;

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
        this.actual_price,
        this.discount,
        this.total,
        this.approved});

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
    actual_price = json['actual_price'].toString();
    discount = json['discount'].toString();
    total = json['total'].toString();
    approved = json['approved'];
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
    data['total'] = this.total.toString();
    data['approved'] = this.approved;
    return data;
  }
}

class ProductImage {
  int id;
  String image;

  ProductImage({this.id, this.image});

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
