/*
{
  "collectionId": "pbc_4092854851",
  "collectionName": "Products",
  "id": "test",
  "name": "test",
  "description": "test",
  "price": 123,
  "image": [
    "filename.jpg"
  ],
  "stock": 123,
  "category": "RELATION_RECORD_ID",
  "created": "2022-01-01 10:00:00.123Z",
  "updated": "2022-01-01 10:00:00.123Z"
}
*/

import 'dart:convert';

ProductDetailResponseModel productDetailResponseModelFromJson(String str) => ProductDetailResponseModel.fromJson(json.decode(str));

String productDetailResponseModelToJson(ProductDetailResponseModel data) => json.encode(data.toJson());

class ProductDetailResponseModel {
  String collectionId;
  String collectionName;
  String id;
  String name;
  String description;
  int price;
  List<String> image;
  int stock;
  String category;
  DateTime created;
  DateTime updated;

  ProductDetailResponseModel({
    required this.collectionId,
    required this.collectionName,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.stock,
    required this.category,
    required this.created,
    required this.updated,
  });

  factory ProductDetailResponseModel.fromJson(Map<String, dynamic> json) => ProductDetailResponseModel(
    collectionId: json["collectionId"],
    collectionName: json["collectionName"],
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    image: List<String>.from(json["image"].map((x) => x)),
    stock: json["stock"],
    category: json["category"],
    created: DateTime.parse(json["created"]),
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "collectionId": collectionId,
    "collectionName": collectionName,
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "image": List<dynamic>.from(image.map((x) => x)),
    "stock": stock,
    "category": category,
    "created": created.toIso8601String(),
    "updated": updated.toIso8601String(),
  };
}

