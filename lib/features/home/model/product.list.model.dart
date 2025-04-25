// To parse this JSON data, do
//
//     final productListResponseModel = productListResponseModelFromJson(jsonString);

import 'dart:convert';

ProductListResponseModel productListResponseModelFromJson(String str) => ProductListResponseModel.fromJson(json.decode(str));

String productListResponseModelToJson(ProductListResponseModel data) => json.encode(data.toJson());

class ProductListResponseModel {
  int page;
  int perPage;
  int totalPages;
  int totalItems;
  List<Item> items;

  ProductListResponseModel({
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.totalItems,
    required this.items,
  });

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) => ProductListResponseModel(
    page: json["page"],
    perPage: json["perPage"],
    totalPages: json["totalPages"],
    totalItems: json["totalItems"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "perPage": perPage,
    "totalPages": totalPages,
    "totalItems": totalItems,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
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

  Item({
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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
