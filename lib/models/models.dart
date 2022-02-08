import 'dart:convert';

import 'package:food_app/models/store_model.dart';

class CategoryModel {
  int id;
  String title;
  String image;
  // List<ItemModel>? itemsList;
  // List<StoreModel> storeList;
  CategoryModel(
    this.id,
    this.title,
    this.image,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      map['id']?.toInt() ?? 0,
      map['title'] ?? '',
      map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}

class ItemModel {
  dynamic id;
  dynamic storeId;
  String name;
  String description;
  String image;
  double? reviews;
  double price;
  int status;
  List<ChoiceModel>? choicesList;
  ItemModel({
    required this.id,
    required this.storeId,
    required this.name,
    required this.description,
    required this.image,
    this.reviews,
    required this.price,
    required this.status,
    this.choicesList,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storeId': storeId,
      'name': name,
      'description': description,
      'image': image,
      'reviews': reviews,
      'price': price,
      'status': status,
      'choicesList': choicesList?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] ?? null,
      storeId: map['storeId'] ?? null,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      reviews: map['reviews']?.toDouble(),
      price: map['price']?.toDouble() ?? 0.0,
      status: map['status']?.toInt() ?? 0,
      choicesList: map['choicesList'] != null
          ? List<ChoiceModel>.from(
              map['choicesList']?.map((x) => ChoiceModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));
}

class ChoiceModel {
  int id;
  String title;
  List<SubChoiceModel>? subChoicesList;

  ChoiceModel(this.id, this.title, this.subChoicesList);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subChoicesList': subChoicesList?.map((x) => x.toMap()).toList(),
    };
  }

  factory ChoiceModel.fromMap(Map<String, dynamic> map) {
    return ChoiceModel(
      map['id']?.toInt() ?? 0,
      map['title'] ?? '',
      map['subChoicesList'] != null
          ? List<SubChoiceModel>.from(
              map['subChoicesList']?.map((x) => SubChoiceModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChoiceModel.fromJson(String source) =>
      ChoiceModel.fromMap(json.decode(source));
}

class SubChoiceModel {
  int id;
  String title;
  double price;

  SubChoiceModel(this.id, this.title, this.price);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
    };
  }

  factory SubChoiceModel.fromMap(Map<String, dynamic> map) {
    return SubChoiceModel(
      map['id']?.toInt() ?? 0,
      map['title'] ?? '',
      map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubChoiceModel.fromJson(String source) =>
      SubChoiceModel.fromMap(json.decode(source));
}

class CartModel {
  int id;
  String title;
  String description;
  String image;
  double price;

  CartModel(this.id, this.title, this.description, this.image, this.price);
}

class LanguageModel {
  String code;
  String title;

  LanguageModel(this.code, this.title);
}
