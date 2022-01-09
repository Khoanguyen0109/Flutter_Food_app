import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  static Future get(String url, Map<String, dynamic>? params) async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
      });
      final responseJson = jsonDecode(response.body);

      return responseJson;
    } catch (e) {
      throw new Exception("AJAX ERROR");
    }
  }

  static Future update(String url, Map<String, dynamic>? data,
      {String medthod = 'POST'}) async {
    try {
      dynamic response;
      if (medthod == 'POST') {
        response =
            await http.post(Uri.parse(url), body: json.encode(data), headers: {
          HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
        });
      } else {
        response =
            await http.put(Uri.parse(url), body: json.encode(data), headers: {
          HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
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
