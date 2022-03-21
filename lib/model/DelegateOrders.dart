class DelegateOrders {
  DelegateOrders({
      this.status, 
      this.message, 
      this.code, 
      this.data,});

  DelegateOrders.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(DelegateOrder.fromJson(v));
      });
    }
  }
  bool status;
  String message;
  int code;
  List<DelegateOrder> data;

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

class DelegateOrder {
  DelegateOrder({
      this.id, 
      this.distance,
      this.description,
      this.donationNumber,
      this.status_id,
      this.donationUsername,
      this.donationEmail,
      this.donationMobile, 
      this.donationGender, 
      this.donationAddress, 
      this.donationLongitude, 
      this.donationLatitude, 
      this.donationregion, 
      this.recipientUsername, 
      this.recipientEmail, 
      this.recipientMobile, 
      this.recipientGender, 
      this.recipientAddress, 
      this.recipientLongitude, 
      this.recipientLatitude, 
      this.recipientregion, 
      this.status, 
      this.close,});

  DelegateOrder.fromJson(dynamic json) {
    id = json['id'];
    donationNumber = json['donation_number'];
    distance = json['distance'];
    description = json['description'];
    donationUsername = json['donationUsername'];
    status_id = json['status_id'];
    donationEmail = json['donationEmail'];
    donationMobile = json['donationMobile'];
    donationGender = json['donationGender'];
    donationAddress = json['donationAddress'];
    donationLongitude = json['donationLongitude'];
    donationLatitude = json['donationLatitude'];
    donationregion = json['donationregion'];
    recipientUsername = json['recipientUsername'];
    recipientEmail = json['recipientEmail'];
    recipientMobile = json['recipientMobile'];
    recipientGender = json['recipientGender'];
    recipientAddress = json['recipientAddress'];
    recipientLongitude = json['recipientLongitude'];
    recipientLatitude = json['recipientLatitude'];
    recipientregion = json['recipientregion'];
    status = json['status'];
    close = json['close'];
  }
  String id;
  String donationNumber;
  String description;
  String distance;
  String donationUsername;
  String status_id;
  String donationEmail;
  String donationMobile;
  String donationGender;
  String donationAddress;
  String donationLongitude;
  String donationLatitude;
  String donationregion;
  String recipientUsername;
  String recipientEmail;
  String recipientMobile;
  String recipientGender;
  String recipientAddress;
  String recipientLongitude;
  String recipientLatitude;
  String recipientregion;
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
    map['recipientUsername'] = recipientUsername;
    map['recipientEmail'] = recipientEmail;
    map['recipientMobile'] = recipientMobile;
    map['recipientGender'] = recipientGender;
    map['recipientAddress'] = recipientAddress;
    map['recipientLongitude'] = recipientLongitude;
    map['recipientLatitude'] = recipientLatitude;
    map['recipientregion'] = recipientregion;
    map['status'] = status;
    map['close'] = close;
    return map;
  }

}