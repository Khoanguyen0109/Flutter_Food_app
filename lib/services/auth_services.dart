import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/pages/auth/utls.dart';
import 'package:food_app/utils/apiService.dart';
import 'package:food_app/utils/toast_utls.dart';
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
      final responseJson = jsonDecode(response.body);
      if (response.statusCode == 400) {
        ToastUtils.toastFailed(responseJson['errors'][0]['detail']);
      }
      if (response.statusCode == 201) {
        print(responseJson['data']);
        return User.fromMap(responseJson['data']);
      }
    } catch (e) {
      print(e);
      ToastUtils.toastFailed('Something went wrong');
    }
  }

  static Future<String?> login(String email, password) async {
    try {
      final response = await http.post(
        Uri.parse('$api' + 'auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': email,
          'password': password,
          // 'guard': 'user'
        }),
      );
      final responseJson = jsonDecode(response.body);

      print(responseJson);
      if (response.statusCode == 200) {
        print(response);
        print(responseJson);

        return responseJson['access_token'];
      }
      if (response.statusCode == 401) {
        ToastUtils.toastFailed('Wrong email or password');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<User?> getUser(String token) async {
    try {
      String url = 'auth/profile';
      final response = await ApiService.get(url, {token: token});
      print(response);
      return User.fromMap(response['data']);
    } catch (e) {
      print(e.toString());
      // ToastUtils.toastFailed('Something went wrong');
    }
  }

  static Future updateUserInfo(Map<String, dynamic> data) async {
    try {
      String url = '$api' + 'auth/profile';
      final response = await ApiService.update(url, data);
      print(response);
      return User.fromMap(response['data']);
    } catch (e) {
      print(e.toString());
      ToastUtils.toastFailed('Something went wrong');
    }
  }

  static Future changePassword(Map<String, dynamic> data) async {
    try {
      String url = '$api' + 'auth/profile';
      final response = await ApiService.update(url, data);
      print(response);
      return User.fromMap(response['data']);
    } catch (e) {
      print(e.toString());
      ToastUtils.toastFailed('Something went wrong');
    }
  }

  static Future signOut() async {
    try {
      // const url = '';
      // final response = await ApiService.get(url, null);
      // final responseJson = jsonDecode(response.body);

      // return User.fromJson(responseJson);
      return null;
    } catch (e) {}
  }
}
