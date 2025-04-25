// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  String collectionId;
  String collectionName;
  String id;
  String email;
  bool emailVisibility;
  bool verified;
  String name;
  String avatar;
  String role;
  DateTime created;
  DateTime updated;

  RegisterResponseModel({
    required this.collectionId,
    required this.collectionName,
    required this.id,
    required this.email,
    required this.emailVisibility,
    required this.verified,
    required this.name,
    required this.avatar,
    required this.role,
    required this.created,
    required this.updated,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
    collectionId: json["collectionId"],
    collectionName: json["collectionName"],
    id: json["id"],
    email: json["email"],
    emailVisibility: json["emailVisibility"],
    verified: json["verified"],
    name: json["name"],
    avatar: json["avatar"],
    role: json["role"],
    created: DateTime.parse(json["created"]),
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "collectionId": collectionId,
    "collectionName": collectionName,
    "id": id,
    "email": email,
    "emailVisibility": emailVisibility,
    "verified": verified,
    "name": name,
    "avatar": avatar,
    "role": role,
    "created": created.toIso8601String(),
    "updated": updated.toIso8601String(),
  };
}
