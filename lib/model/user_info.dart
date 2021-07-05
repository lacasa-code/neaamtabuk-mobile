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
  int wishlistsCount;
  int historyCount;
  String paymentMethod;
  String lastTransactionTime;
  String lastName;
  String phoneNo;
  String CountroyCode;
  String birthdate;
  String gender;
  User(
      {this.name,
        this.email,
        this.wishlistsCount,
        this.historyCount,
        this.paymentMethod,
        this.lastTransactionTime,
        this.lastName,
        this.phoneNo,
        this.birthdate,
        this.gender});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    wishlistsCount = json['wishlists_count'];
    historyCount = json['history_count'];
    paymentMethod = json['payment_method'];
    lastTransactionTime = json['last_transaction_time'];
    lastName = json['last_name'];
    phoneNo = json['phone_no'];
    birthdate = json['birthdate'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['wishlists_count'] = this.wishlistsCount;
    data['history_count'] = this.historyCount;
    data['payment_method'] = this.paymentMethod;
    data['last_transaction_time'] = this.lastTransactionTime;
    data['last_name'] = this.lastName;
    data['phone_no'] = this.phoneNo;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    return data;
  }
}
