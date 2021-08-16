class Reasons {
  int statusCode;
  String message;
  List<Reason> data;

  Reasons({this.statusCode, this.message, this.data});

  Reasons.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Reason>();
      json['data'].forEach((v) {
        data.add(new Reason.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reason {
  int id;
  String field;
  String lang;
  String rejReason;
  String createdAt;
  String updatedAt;

  Reason(
      {this.id,
        this.field,
        this.lang,
        this.rejReason,
        this.createdAt,
        this.updatedAt});

  Reason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = json['field'];
    lang = json['lang'];
    rejReason = json['rej_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['field'] = this.field;
    data['lang'] = this.lang;
    data['rej_reason'] = this.rejReason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
