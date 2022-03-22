class DonorOrdersModel {
  DonorOrdersModel({
      this.status, 
      this.message, 
      this.code, 
      this.data,});

  DonorOrdersModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(DonorOrder.fromJson(v));
      });
    }
  }
  bool status;
  String message;
  int code;
  List<DonorOrder> data;

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

class DonorOrder {
  DonorOrder({
      this.donorId, 
      this.donationUsername,
      this.donation_number,
      this.delivary_date,
      this.category_id,
      this.donationNumber,
      this.category, 
      this.readyToDistribute, 
      this.readyToPack, 
      this.status, 
      this.close,});

  DonorOrder.fromJson(dynamic json) {
    donationUsername = json['donationUsername'];
    donationMobile = json['donationMobile'];
    distance = json['distance'];
    donorId = json['donate_id'];
    description = json['description'];
    delivary_date = json['delivary_date'];
    number_of_meals = json['number_of_meals'];
    donation_number = json['donation_number'];
    category_id = "${json['category_id']}";
    donationNumber = json['donation_number'];
    category = json['category'];
    readyToDistribute = json['ready_to_distribute'];
    readyToPack = json['ready_to_pack'];
    status = json['status'];
    close = json['close'];
    category_id = json['category_id'];
    order_id = json['order_id'];
    status_id = json['status_id'];
  }
  String status_id;
  String distance;
  String donation_number;
  String donationUsername;
  String category_id;
  String donationMobile;
  String donorId;
  String number_of_meals;
  String delivary_date;
  String description;
  String donationNumber;
  String category;
  String readyToDistribute;
  String readyToPack;
  String status;
  String order_id;
  dynamic close;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['donor_id'] = donorId;
    map['donation_number'] = donationNumber;
    map['category'] = category;
    map['ready_to_distribute'] = readyToDistribute;
    map['ready_to_pack'] = readyToPack;
    map['status'] = status;
    map['close'] = close;
    return map;
  }

}