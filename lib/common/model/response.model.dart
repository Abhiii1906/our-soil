import 'dart:convert';

ResponseModel? responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  final int ? status;
  final String? message;

  ResponseModel({this.status, this.message});

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    status: json['status'],
    message: json['message'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
  };
}