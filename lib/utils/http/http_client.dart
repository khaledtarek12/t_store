import 'dart:convert';

import 'package:http/http.dart' as http;

// The ApiService class for making HTTP GET, POST, and DELETE requests
class THttpHelper {
  static const _baseUrl = 'https://your-api-base-url.com';

  // static String token = '';

  static Future<Map<String, dynamic>> get({required String endPoint}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('auth-token') == null) {
    //   prefs.setString('auth-token', '');
    // }
    // token = prefs.getString('auth-token');

    // Send a GET request to the specified endPoint by combining it with the base URL
    final response = await http.get(Uri.parse('$_baseUrl/$endPoint'));

    // Return the response data as a map (dynamic) containing key-value pairs
    return _handteResponse(response);
  }

  // Asynchronous function to make a POST request to the API
  static Future<Map<String, dynamic>> post(
      {required String endPoint, required dynamic data}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('auth-token') == null) {
    //   prefs.setString('auth-token', '');
    // }
    // token = prefs.getString('auth-token');

    // Send a POST request to the specified endPoint by combining it with the base URL
    final response = await http.post(Uri.parse('$_baseUrl/$endPoint'),
        headers: {'Content-Type': 'application/json'}, body: json.decode(data));

    // Return the response data as a map (dynamic) containing key-value pairs
    return _handteResponse(response);
  }

  Future<Map<String, dynamic>> put(
      {required String endPoint, required dynamic data}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('auth-token') == null) {
    //   prefs.setString('auth-token', '');
    // }
    // token = prefs.getString('auth-token');

    // Send a POST request to the specified endPoint by combining it with the base URL
    final response = await http.put(Uri.parse('$_baseUrl/$endPoint'),
        headers: {'Content-Type': 'application/json'}, body: json.decode(data));

    // Return the response data as a map (dynamic) containing key-value pairs
    return _handteResponse(response);
  }

  // Asynchronous function to make a DELETE request to the API
  Future<Map<String, dynamic>> delete({required String endPoint}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('auth-token') == null) {
    //   prefs.setString('auth-token', '');
    // }
    // token = prefs.getString('auth-token');

    // Send a DELETE request to the specified endPoint by combining it with the base URL
    final response = await http.delete(Uri.parse('$_baseUrl/$endPoint'));

    // Return the response data as a map (dynamic) containing key-value pairs
    return _handteResponse(response);
  }

  static Map<String, dynamic> _handteResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data : ${response.statusCode}');
    }
  }
}
