class UserInformation {
  int statusCode;
  String message;
  User data;

  UserInformation({this.statusCode, this.message, this.data});

  UserInformation.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class User {
  String name;
  String email;
  String address;
  String phoneNo;
  String region;
  int city;
  String cityName;
  String longitude;
  String latitude;
  String status;
  String role_id;
  String donation_type_id;
  String gender;
  User(
      {this.name,
        this.email,
        this.address,
        this.phoneNo,
        this.region,
        this.gender});

  User.fromJson(Map<String, dynamic> json) {
    name = json['username'];
    email = json['email'];
    address = json['address'];
    city =int.tryParse("${json['city']??0}");
    phoneNo = json['mobile'];
    region = json['region'];
    gender = json['gender'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['last_name'] = this.address;
    data['phone_no'] = this.phoneNo;
    data['region'] = this.region;
    data['gender'] = this.gender;
    return data;
  }
}
