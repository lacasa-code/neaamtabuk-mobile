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
      this.donation_number,
      this.donationNumber,
      this.category, 
      this.readyToDistribute, 
      this.readyToPack, 
      this.status, 
      this.close,});

  DonorOrder.fromJson(dynamic json) {
    donorId = json['donor_id'];
    donation_number = json['donation_number'];
    donationNumber = json['donation_number'];
    category = json['category'];
    readyToDistribute = json['ready_to_distribute'];
    readyToPack = json['ready_to_pack'];
    status = json['status'];
    close = json['close'];
  }
  String donation_number;
  String donorId;
  String donationNumber;
  String category;
  String readyToDistribute;
  String readyToPack;
  String status;
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