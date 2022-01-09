import 'dart:convert';

class Shipper {
  int id;
  String name;
  String image;
  Shipper({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory Shipper.fromMap(Map<String, dynamic> map) {
    return Shipper(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Shipper.fromJson(String source) =>
      Shipper.fromMap(json.decode(source));
}
