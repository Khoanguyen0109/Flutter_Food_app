import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static String api = '${dotenv.get('API_URL')}/';

  static Future get(String url, Map<String, dynamic>? params) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      String apiUrl = '$api' + '$url';
      print(apiUrl);
      if (accessToken != null) {
        final response = await http.get(Uri.parse(apiUrl), headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        });
        final responseJson = jsonDecode(response.body);
        return responseJson;
      }
    } catch (e) {
      print(e.toString());
      // throw new Exception("AJAX ERROR");
    }
  }

  static Future update(String url, Map<String, dynamic>? data,
      {String medthod = 'POST'}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    try {
      dynamic response;
      if (medthod == 'POST') {
        response =
            await http.post(Uri.parse(url), body: json.encode(data), headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        });
      } else {
        response =
            await http.put(Uri.parse(url), body: json.encode(data), headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        });
      }

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        return responseJson;
      }
    } catch (e) {
      throw new Exception("AJAX ERROR");
    }
  }

  static Future delete(String url, Map<String, dynamic>? params) async {
    try {
      final response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
      });
      final responseJson = jsonDecode(response.body);
      return responseJson;
    } catch (e) {
      throw new Exception("AJAX ERROR");
    }
  }
}
