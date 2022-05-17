// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  bool status;
  String message;
  int code;
  Data data;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.uuid,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.phoneVerifiedAt,
    this.image,
    this.countryId,
    this.cityId,
    this.areaId,
    this.address,
    this.longitude,
    this.latitude,
    this.lastLogin,
    this.inBlock,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String uuid;
  String username;
  String email;
  dynamic emailVerifiedAt;
  String phone;
  dynamic phoneVerifiedAt;
  String image;
  String countryId;
  String cityId;
  String areaId;
  String address;
  String longitude;
  String latitude;
  DateTime lastLogin;
  dynamic inBlock;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uuid: json["uuid"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phone: json["mobile"] ?? json["phone"],
        phoneVerifiedAt: json["phone_verified_at"],
        image: json["image"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        areaId: json["area_id"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        inBlock: json["in_block"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone,
        "phone_verified_at": phoneVerifiedAt,
        "image": image,
        "country_id": countryId,
        "city_id": cityId,
        "area_id": areaId,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "last_login": lastLogin?.toIso8601String(),
        "in_block": inBlock,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
