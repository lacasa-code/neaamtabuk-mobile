class Favourite {
  int statusCode;
  String message;
  List<Fav> data;
  int total;

  Favourite({this.statusCode, this.message, this.data, this.total});

  Favourite.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Fav>();
      json['data'].forEach((v) {
        data.add(new Fav.fromJson(v));
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

class Fav {
  int id;
  int userId;
  String userName;
  int carMadeId;
  String carMadeName;
  int carTypeId;
  String carTypeName;
  int carModelId;
  String carModelName;
  int carYearId;
  String carYearIdName;
  int transmissionId;
  String transmissionName;
  String timeCreated;

  Fav(
      {this.id,
        this.userId,
        this.userName,
        this.carMadeId,
        this.carMadeName,
        this.carTypeId,
        this.carTypeName,
        this.carModelId,
        this.carModelName,
        this.carYearId,
        this.carYearIdName,
        this.transmissionId,
        this.transmissionName,
        this.timeCreated});

  Fav.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    carMadeId = json['car_made_id'];
    carMadeName = json['car_made_name'];
    carTypeId = json['car_type_id'];
    carTypeName = json['car_type_name'];
    carModelId = json['car_model_id'];
    carModelName = json['car_model_name'];
    carYearId = json['car_year_id'];
    carYearIdName = json['car_year_id_name'];
    transmissionId = json['transmission_id'];
    transmissionName = json['transmission_name'];
    timeCreated = json['time_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['car_made_id'] = this.carMadeId;
    data['car_made_name'] = this.carMadeName;
    data['car_type_id'] = this.carTypeId;
    data['car_type_name'] = this.carTypeName;
    data['car_model_id'] = this.carModelId;
    data['car_model_name'] = this.carModelName;
    data['car_year_id'] = this.carYearId;
    data['car_year_id_name'] = this.carYearIdName;
    data['transmission_id'] = this.transmissionId;
    data['transmission_name'] = this.transmissionName;
    data['time_created'] = this.timeCreated;
    return data;
  }
}
