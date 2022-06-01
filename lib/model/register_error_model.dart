// To parse this JSON data, do
//
//     final registerErrorModel = registerErrorModelFromJson(jsonString);

import 'dart:convert';

RegisterErrorModel registerErrorModelFromJson(String str) =>
    RegisterErrorModel.fromJson(json.decode(str));

String registerErrorModelToJson(RegisterErrorModel data) =>
    json.encode(data.toJson());

class RegisterErrorModel {
  RegisterErrorModel({
    this.status,
    this.message,
    this.code,
  });

  bool status;
  Map<String, List<String>> message;
  int code;

  factory RegisterErrorModel.fromJson(Map<String, dynamic> json) =>
      RegisterErrorModel(
        status: json["status"],
        message: json["message"].runtimeType == String
            ? null
            : Map.from(json["message"]).map((k, v) =>
                MapEntry<String, List<String>>(
                    k, List<String>.from(v.map((x) => x)))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": Map.from(message).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "code": code,
      };
}
