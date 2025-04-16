// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  Record record;
  String token;

  LoginResponseModel({
    required this.record,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    record: Record.fromJson(json["record"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "record": record.toJson(),
    "token": token,
  };
}

class Record {
  String avatar;
  String collectionName;
  String email;
  bool emailVisibility;
  String id;
  String name;
  String role;
  bool verified;

  Record({
    required this.avatar,
    required this.collectionName,
    required this.email,
    required this.emailVisibility,
    required this.id,
    required this.name,
    required this.role,
    required this.verified,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    avatar: json["avatar"],
    collectionName: json["collectionName"],
    email: json["email"],
    emailVisibility: json["emailVisibility"],
    id: json["id"],
    name: json["name"],
    role: json["role"],
    verified: json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "collectionName": collectionName,
    "email": email,
    "emailVisibility": emailVisibility,
    "id": id,
    "name": name,
    "role": role,
    "verified": verified,
  };
}
