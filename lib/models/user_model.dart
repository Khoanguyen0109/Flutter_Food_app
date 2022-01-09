import 'dart:convert';

class User {
  final String uid;
  final String? email;
  // final String? phone;
  User({
    required this.uid,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
