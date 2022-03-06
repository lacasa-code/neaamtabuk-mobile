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
      this.donationUsername, 
      this.donationEmail, 
      this.donationMobile, 
      this.donationGender, 
      this.donationAddress, 
      this.donationLongitude, 
      this.donationLatitude, 
      this.donationregion, 
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
    donationUsername = json['donationUsername'];
    donationEmail = json['donationEmail'];
    donationMobile = json['donationMobile'];
    donationGender = json['donationGender'];
    donationAddress = json['donationAddress'];
    donationLongitude = json['donationLongitude'];
    donationLatitude = json['donationLatitude'];
    donationregion = json['donationregion'];
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
  String donationUsername;
  String donationEmail;
  String donationMobile;
  String donationGender;
  String donationAddress;
  String donationLongitude;
  String donationLatitude;
  String donationregion;
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
    map['donationUsername'] = donationUsername;
    map['donationEmail'] = donationEmail;
    map['donationMobile'] = donationMobile;
    map['donationGender'] = donationGender;
    map['donationAddress'] = donationAddress;
    map['donationLongitude'] = donationLongitude;
    map['donationLatitude'] = donationLatitude;
    map['donationregion'] = donationregion;
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