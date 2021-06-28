class ShippingAddress {
  int statusCode;
  String message;
  List<Address> data;

  ShippingAddress({this.statusCode, this.message, this.data});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Address>();
      json['data'].forEach((v) {
        data.add(new Address.fromJson(v));
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

class Address {
  int id;
  int userId;
  String userName;
  int status;
  String recipientName;
  String recipientPhone;
  String recipientAltPhone;
  String recipientEmail;
  String address;
  String city;
  String state;
  String countryCode;
  String street;
  String postalCode;
  String latitude;
  String longitude;
  String lastName;
  String area;
  String district;
  String homeNo;
  String floorNo;
  String apartmentNo;
  String telephoneNo;
  String nearestMilestone;
  String notices;
  String createdAt;
  String timeCreated;

  Address(
      {this.id,
        this.userId,
        this.userName,
        this.status,
        this.recipientName,
        this.recipientPhone,
        this.recipientAltPhone,
        this.recipientEmail,
        this.address,
        this.city,
        this.state,
        this.countryCode,
        this.postalCode,
        this.latitude,
        this.longitude,
        this.lastName,
        this.area,
        this.district,
        this.homeNo,
        this.floorNo,
        this.apartmentNo,
        this.telephoneNo,
        this.nearestMilestone,
        this.notices,
        this.createdAt,
        this.street,
        this.timeCreated});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    status = json['status'];
    recipientName = json['recipient_name'];
    recipientPhone = json['recipient_phone'];
    recipientAltPhone = json['recipient_alt_phone'];
    recipientEmail = json['recipient_email'];
    address = json['address'];
    city = json['city'].toString();
    street = json['street'];
    countryCode = json['country_code'];
    postalCode = json['postal_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    lastName = json['last_name'];
    area = json['area'].toString();
    district = json['district'];
    homeNo = json['home_no'];
    floorNo = json['floor_no'];
    apartmentNo = json['apartment_no'];
    telephoneNo = json['telephone_no'];
    nearestMilestone = json['nearest_milestone'];
    notices = json['notices'];
    createdAt = json['created_at'];
    timeCreated = json['time_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipient_name'] = this.recipientName;
    data['recipient_phone'] = this.recipientPhone;
    data['recipient_alt_phone'] = this.recipientAltPhone;
    data['recipient_email'] = this.recipientEmail;
    data['city_id'] = this.city;
    data['state'] = this.state;
    data['country_id'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['last_name'] = this.lastName;
    data['street']=this.street;
    data['area_id'] = this.area;
    data['district'] = this.district;
    data['home_no'] = this.homeNo;
    data['floor_no'] = this.floorNo;
    data['apartment_no'] = this.apartmentNo;
    data['telephone_no'] = this.telephoneNo;
    data['nearest_milestone'] = this.nearestMilestone;
    data['notices'] = this.notices;
    return data;
  }
}
