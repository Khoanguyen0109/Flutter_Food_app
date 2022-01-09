import 'dart:convert';

class NotificationModel {
  int id;
  String title;
  String message;
  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));
}
