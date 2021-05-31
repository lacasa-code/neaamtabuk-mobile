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
  String name,lastname;
  String email,phone,gender,bithdate;
  int wishlistsCount;
  int historyCount;
  List<UserShippings> userShippings;
  String paymentMethod;
  String lastTransactionTime;

  User(
      {this.name,
        this.email,
        this.wishlistsCount,
        this.historyCount,
        this.userShippings,
        this.paymentMethod,
        this.lastTransactionTime});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    wishlistsCount = json['wishlists_count'];
    historyCount = json['history_count'];
    if (json['user_shippings'] != null) {
      userShippings = new List<UserShippings>();
      json['user_shippings'].forEach((v) {
        userShippings.add(new UserShippings.fromJson(v));
      });
    }
    paymentMethod = json['payment_method'];
    lastTransactionTime = json['last_transaction_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['wishlists_count'] = this.wishlistsCount;
    data['history_count'] = this.historyCount;
    if (this.userShippings != null) {
      data['user_shippings'] =
          this.userShippings.map((v) => v.toJson()).toList();
    }
    data['payment_method'] = this.paymentMethod;
    data['last_transaction_time'] = this.lastTransactionTime;
    return data;
  }
}

class UserShippings {
  int id;
  int userId;
  String recipientName;
  String recipientPhone;
  Null recipientAltPhone;
  String recipientEmail;
  String address;
  String city;
  String state;
  String countryCode;
  String postalCode;
  String latitude;
  String longitude;
  int status;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String lang;
  String lastName;
  String area;
  String homeNo;
  String floorNo;
  String apartmentNo;
  String telephoneNo;
  String nearestMilestone;
  String notices;
  String district;

  UserShippings(
      {this.id,
        this.userId,
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
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.lang,
        this.lastName,
        this.area,
        this.homeNo,
        this.floorNo,
        this.apartmentNo,
        this.telephoneNo,
        this.nearestMilestone,
        this.notices,
        this.district});

  UserShippings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    recipientName = json['recipient_name'];
    recipientPhone = json['recipient_phone'];
    recipientAltPhone = json['recipient_alt_phone'];
    recipientEmail = json['recipient_email'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    countryCode = json['country_code'];
    postalCode = json['postal_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    lang = json['lang'];
    lastName = json['last_name'];
    area = json['area'];
    homeNo = json['home_no'];
    floorNo = json['floor_no'];
    apartmentNo = json['apartment_no'];
    telephoneNo = json['telephone_no'];
    nearestMilestone = json['nearest_milestone'];
    notices = json['notices'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['recipient_name'] = this.recipientName;
    data['recipient_phone'] = this.recipientPhone;
    data['recipient_alt_phone'] = this.recipientAltPhone;
    data['recipient_email'] = this.recipientEmail;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country_code'] = this.countryCode;
    data['postal_code'] = this.postalCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['lang'] = this.lang;
    data['last_name'] = this.lastName;
    data['area'] = this.area;
    data['home_no'] = this.homeNo;
    data['floor_no'] = this.floorNo;
    data['apartment_no'] = this.apartmentNo;
    data['telephone_no'] = this.telephoneNo;
    data['nearest_milestone'] = this.nearestMilestone;
    data['notices'] = this.notices;
    data['district'] = this.district;
    return data;
  }
}
