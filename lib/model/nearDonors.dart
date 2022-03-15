class NearDonors {
  NearDonors({
      this.status, 
      this.message, 
      this.code, 
      this.data,});

  NearDonors.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(NearDonor.fromJson(v));
      });
    }
  }
  bool status;
  String message;
  int code;
  List<NearDonor> data;

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

class NearDonor {
  NearDonor({
      this.id, 
      this.username, 
      this.status_id,
      this.mobile,
      this.gender, 
      this.address, 
      this.longitude, 
      this.latitude, 
      this.distance,});

  NearDonor.fromJson(dynamic json) {
    id = json['id'].toString();
    username = json['username'];
    mobile = json['mobile'];
    gender = json['gender'];
    address = json['address'];
    status_id = json['status_id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    distance = json['distance'];
  }
  String id;
  String username;
  String status_id;
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