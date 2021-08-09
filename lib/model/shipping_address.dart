import 'package:flutter_pos/model/area_model.dart';
import 'package:flutter_pos/model/city_model.dart';
import 'package:flutter_pos/model/country_model.dart';

class ShippingAddress {
  int statusCode;
  String message;
  List<Address> data;
  int total;

  ShippingAddress({this.statusCode, this.message, this.data, this.total});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Address>();
      json['data'].forEach((v) {
        data.add(new Address.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
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
  int Country_id;
  int area_id;
  int city_id;
  Country state;
  Area area;
  City city;
  String lastName;
  String street;
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
      this.state,
      this.area,
      this.city,
      this.lastName,
      this.street,
      this.district,
      this.homeNo,
      this.floorNo,
      this.apartmentNo,
      this.telephoneNo,
      this.nearestMilestone,
      this.notices,
      this.createdAt,
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
    state = json['state'] != null ? new Country.fromJson(json['state']) : null;
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    lastName = json['last_name'];
    street = json['street'];
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
    if (this.id != null) {
      data['id'] = this.id;
    }
    data['recipient_name'] = this.recipientName;
    data['recipient_phone'] = this.recipientPhone;
    data['address'] = this.address;
    data['country_id'] = this.Country_id;
    data['city_id'] = this.city_id;
    data['area_id'] = this.area_id;
    data['last_name'] = this.lastName;
    data['street'] = this.street;
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
