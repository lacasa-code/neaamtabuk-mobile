class OrdersModel {
  OrdersModel({
      this.status, 
      this.message, 
      this.code, 
      this.data,});

  OrdersModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Order.fromJson(v));
      });
    }
  }
  bool status;
  String message;
  int code;
  List<Order> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['code'] = code;
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Order {
  Order({
      this.id, 
      this.donationId, 
      this.delegateId, 
      this.recipientId, 
      this.statusId, 
      this.closeAt, 
      this.createdAt, 
      this.updatedAt, 
      this.donationNumber, 
      this.categoryId, 
      this.donorId, 
      this.readyToDistribute, 
      this.readyToPack, 
      this.nameEn,});

  Order.fromJson(dynamic json) {
    id = json['id'].toString();
    donationId = json['donation_id'];
    delegateId = json['delegate_id'];
    recipientId = json['recipient_id'];
    statusId = json['status_id'];
    closeAt = json['close_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    donationNumber = json['donation_number'];
    categoryId = json['category_id'];
    donorId = json['donor_id'];
    readyToDistribute = json['ready_to_distribute'];
    readyToPack = json['ready_to_pack'];
    nameEn = json['name_en'];
  }
  String id;
  String donationId;
  String delegateId;
  String recipientId;
  String statusId;
  String closeAt;
  String createdAt;
  String updatedAt;
  String donationNumber;
  String categoryId;
  String donorId;
  String readyToDistribute;
  String readyToPack;
  String nameEn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['donation_id'] = donationId;
    map['delegate_id'] = delegateId;
    map['recipient_id'] = recipientId;
    map['status_id'] = statusId;
    map['close_at'] = closeAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['donation_number'] = donationNumber;
    map['category_id'] = categoryId;
    map['donor_id'] = donorId;
    map['ready_to_distribute'] = readyToDistribute;
    map['ready_to_pack'] = readyToPack;
    map['name_en'] = nameEn;
    return map;
  }

}