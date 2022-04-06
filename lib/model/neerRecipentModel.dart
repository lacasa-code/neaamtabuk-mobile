class NearRecipentModel {
  NearRecipentModel({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  NearRecipentModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(NearRecipent.fromJson(v));
      });
    } else {
      data = [];
    }
  }
  bool status;
  String message;
  int code;
  List<NearRecipent> data;

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

class NearRecipent {
  NearRecipent({
    this.id,
    this.family_members,
    this.username,
    this.mobile,
    this.gender,
    this.address,
    this.longitude,
    this.latitude,
    this.distance,
  });

  NearRecipent.fromJson(dynamic json) {
    id = json['id'];
    family_members = json['family_members'];
    username = json['username'];
    mobile = json['mobile'];
    gender = json['gender'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    distance = json['distance'];
  }
  int id;
  String username;
  String family_members;
  String mobile;
  String gender;
  String address;
  String longitude;
  String latitude;
  String distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['mobile'] = mobile;
    map['gender'] = gender;
    map['address'] = address;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['distance'] = distance;
    return map;
  }
}
