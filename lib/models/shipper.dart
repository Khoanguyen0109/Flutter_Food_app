import 'dart:convert';

class Shipper {
  dynamic id;
  String name;
  String image;
  String phone;
  String? numberPlate;
  Shipper({
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
    this.numberPlate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'phone': phone,
      'numberPlate': numberPlate,
    };
  }

  factory Shipper.fromMap(Map<String, dynamic> map) {
    return Shipper(
      id: map['id'] ?? null,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      phone: map['phone'] ?? '',
      numberPlate: map['phone_plate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Shipper.fromJson(String source) =>
      Shipper.fromMap(json.decode(source));
}
