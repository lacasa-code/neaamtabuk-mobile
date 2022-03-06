class AreaModel {
  AreaModel({
      this.status, 
      this.message, 
      this.code, 
      this.data,});

  AreaModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Area.fromJson(v));
      });
    }
  }
  bool status;
  String message;
  int code;
  List<Area> data;

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

class Area {
  Area({
      this.nameAr,});

  Area.fromJson(dynamic json) {
    nameAr = json['name_ar'];
  }
  String nameAr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name_ar'] = nameAr;
    return map;
  }

}