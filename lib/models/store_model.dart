import 'dart:convert';

class StoreModel {
  int id;
  String name;
  String description;
  String image;
  String address;
  String category;
  double review;
  int? status;
  StoreModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.address,
    required this.category,
    required this.review,
    this.status
  });

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
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      address: map['address'] ?? '',
      category: map['category'] ?? '',
      review: map['review']?.toDouble() ?? 0.0,
      status: map['status']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) => StoreModel.fromMap(json.decode(source));
}
