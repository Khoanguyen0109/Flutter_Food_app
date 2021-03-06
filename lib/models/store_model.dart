import 'dart:convert';

import 'package:food_app/models/models.dart';

class StoreModel {
  String id;
  String name;
  String description;
  String image;
  String address;
  int category;
  double review;
  int? status;
  List<ItemModel>? items;
  StoreModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.address,
      required this.category,
      required this.review,
      this.status,
      this.items});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'address': address,
      'category': category,
      'review': review,
      'status': status,
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'] ?? '',
      name: map['merchant_name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      address: map['address'] ?? '',
      category: map['category'] ?? '',
      review: map['review']?.toDouble() ?? 0.0,
      status: map['status'] ?? 0,
      items: map['dishes'] != null
          ? List<ItemModel>.from(
              map['dishes']?.map((x) => ItemModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) =>
      StoreModel.fromMap(json.decode(source));
}
