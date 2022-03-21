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
      this.donation_number,
      this.readyToDistribute,
      this.readyToPack,
      this.username,
      this.number_of_meals,
      this.category_id,
      this.category,
      this.description,
      this.delivary_date,
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
    category_id = json['category_id'];
    donation_number = json['donation_number'];
    description = json['description'];
    category = json['category'];
    delivary_date = json['delivary_date'];
    number_of_meals = json['number_of_meals'];
    mobile = json['mobile'];
    gender = json['gender'];
    address = json['address'];
    status_id = json['status_id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    distance = json['distance'];
    readyToDistribute = json['ready_to_distribute'];
    readyToPack = json['ready_to_pack'];
  }
  String id;
  String username;
  String category;
  String readyToDistribute;
  String readyToPack;
  String category_id;
  String number_of_meals;
  String delivary_date;
  String description;
  String donation_number;
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