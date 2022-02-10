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
      map['id'] ?? 0,
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
    List<SubChoiceModel>? _subChoiceList;
    List<ChoiceModel>? _choiceList;
    _subChoiceList = [
      SubChoiceModel(1, 'Meat Ball Pasta', 5.00),
      SubChoiceModel(2, 'Meat', 9.00),
      SubChoiceModel(3, 'Ball Pasta', 0),
      SubChoiceModel(4, 'Cheese', 8.00),
    ];

    _choiceList = [
      ChoiceModel(1, 'Meat Ball Pasta', _subChoiceList),
      ChoiceModel(2, 'Meat', _subChoiceList),
      ChoiceModel(3, 'Ball Pasta', _subChoiceList),
      ChoiceModel(4, 'Cheese', _subChoiceList),
    ];
    try {
      return ItemModel(
          id: map['id'] ?? null,
          storeId: map['merchant_id'] ?? null,
          name: map['dish_name'] ?? '',
          description: map['desc'] ?? '',
          image: map['image'] ?? '',
          reviews: map['reviews']?.toDouble() ?? 0,
          price: double.parse("${map['price']}").toDouble() ?? 0.0,
          status: map['status'] ?? 0,
          choicesList: _choiceList);
    } catch (e) {
      print(e);
      rethrow;
    }
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
      map['id'] ?? 0,
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
      map['id'] ?? 0,
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
