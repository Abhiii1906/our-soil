// To parse this JSON data, do
//
//     final categoryListResponseModel = categoryListResponseModelFromJson(jsonString);

import 'dart:convert';

CategoryListResponseModel categoryListResponseModelFromJson(String str) => CategoryListResponseModel.fromJson(json.decode(str));

String categoryListResponseModelToJson(CategoryListResponseModel data) => json.encode(data.toJson());

class CategoryListResponseModel {
  List<Item> items;
  int page;
  int perPage;
  int totalItems;
  int totalPages;

  CategoryListResponseModel({
    required this.items,
    required this.page,
    required this.perPage,
    required this.totalItems,
    required this.totalPages,
  });

  factory CategoryListResponseModel.fromJson(Map<String, dynamic> json) => CategoryListResponseModel(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    page: json["page"],
    perPage: json["perPage"],
    totalItems: json["totalItems"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "page": page,
    "perPage": perPage,
    "totalItems": totalItems,
    "totalPages": totalPages,
  };
}

class Item {
  String collectionId;
  String collectionName;
  DateTime created;
  String description;
  String id;
  String image;
  String name;
  DateTime updated;

  Item({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.description,
    required this.id,
    required this.image,
    required this.name,
    required this.updated,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    collectionId: json["collectionId"],
    collectionName: json["collectionName"],
    created: DateTime.parse(json["created"]),
    description: json["description"],
    id: json["id"],
    image: json["image"],
    name: json["name"],
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "collectionId": collectionId,
    "collectionName": collectionName,
    "created": created.toIso8601String(),
    "description": description,
    "id": id,
    "image": image,
    "name": name,
    "updated": updated.toIso8601String(),
  };
}
