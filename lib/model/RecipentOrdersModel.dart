class RecipentOrdersModel {
  RecipentOrdersModel({
      this.status, 
      this.message, 
      this.code, 
      this.data,});

  RecipentOrdersModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(RecipentOrder.fromJson(v));
      });
    }
  }
  bool status;
  String message;
  int code;
  List<RecipentOrder> data;

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

class RecipentOrder {
  RecipentOrder({
      this.id, 
      this.donationNumber, 
      this.category, 
      this.delegateUsername, 
      this.delegateEmail, 
      this.delegateMobile, 
      this.delegateGender, 
      this.delegateAddress, 
      this.delegateregion, 
      this.delegateLongitude, 
      this.delegateLatitude, 
      this.status, 
      this.close,});

  RecipentOrder.fromJson(dynamic json) {
    id = json['id'];
    donationNumber = json['donation_number'];
    category = json['category'];
    delegateUsername = json['delegateUsername'];
    delegateEmail = json['delegateEmail'];
    delegateMobile = json['delegateMobile'];
    delegateGender = json['delegateGender'];
    delegateAddress = json['delegateAddress'];
    delegateregion = json['delegateregion'];
    delegateLongitude = json['delegateLongitude'];
    delegateLatitude = json['delegateLatitude'];
    status = json['status'];
    close = json['close'];
  }
  String id;
  String donationNumber;
  String category;
  String delegateUsername;
  String delegateEmail;
  String delegateMobile;
  String delegateGender;
  String delegateAddress;
  String delegateregion;
  String delegateLongitude;
  String delegateLatitude;
  String status;
  dynamic close;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['donation_number'] = donationNumber;
    map['category'] = category;
    map['delegateUsername'] = delegateUsername;
    map['delegateEmail'] = delegateEmail;
    map['delegateMobile'] = delegateMobile;
    map['delegateGender'] = delegateGender;
    map['delegateAddress'] = delegateAddress;
    map['delegateregion'] = delegateregion;
    map['delegateLongitude'] = delegateLongitude;
    map['delegateLatitude'] = delegateLatitude;
    map['status'] = status;
    map['close'] = close;
    return map;
  }

}