import 'dart:convert';

class CategoryModel {
  int id;
  String title;
  String image;
  List<ItemModel>? itemsList;

  CategoryModel(this.id, this.title, this.image, this.itemsList);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'itemsList': itemsList?.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      map['id']?.toInt() ?? 0,
      map['title'] ?? '',
      map['image'] ?? '',
      map['itemsList'] != null
          ? List<ItemModel>.from(
              map['itemsList']?.map((x) => ItemModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}

class ItemModel {
  int id;
  int storeId;
  String name;
  String description;
  String image;
  double reviews;
  double price;
  int status;
  List<ChoiceModel>? choicesList;
  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.reviews,
    required this.price,
    required this.status,
    required this.storeId,
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
      'choicesList': choicesList?.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id']?.toInt() ?? 0,
      storeId: map['storeId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      reviews: map['reviews']?.toDouble() ?? 0.0,
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
