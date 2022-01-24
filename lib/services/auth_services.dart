import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/utils/apiService.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static String api = '${dotenv.get('API_URL')}/';

  static Future register(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$api' + 'register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(data),
      );
      // final responseJson = jsonDecode(response.body);
      // print(responseJson.toString());
      return User.fromJson(response.body);
    } catch (e) {
      print(e);
      // throw new Exception("AJAX ERROR");
    }
  }

  static Future<User?> login(String email, password) async {
    try {
      final response = await http.post(
        Uri.parse('$api' + 'auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': email,
          'password': password,
          'guard': 'user'
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response);
        return User.fromJson(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<User?> getUser(String token) async {
    try {
      const url = '';
      final response = await ApiService.get(url, {token: token});
      return User.fromJson(response.body);
    } catch (e) {}
  }

  Future signOut() async {
    try {
      const url = '';
      final response = await ApiService.get(url, null);
      final responseJson = jsonDecode(response.body);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();

      return User.fromJson(responseJson);
    } catch (e) {}
  }
}
