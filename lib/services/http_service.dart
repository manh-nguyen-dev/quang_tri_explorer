import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/logger_util.dart';

class HttpService {
  final String baseUrl = "https://74explorer.vercel.app/api";

  Future<dynamic> get(String endpoint) async {
    final url = '$baseUrl/$endpoint';
    final response = await http.get(Uri.parse(url));
    return _handleResponse(response, url);
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    final url = '$baseUrl/$endpoint';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response, url);
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    final url = '$baseUrl/$endpoint';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response, url);
  }

  Future<dynamic> delete(String endpoint) async {
    final url = '$baseUrl/$endpoint';
    final response = await http.delete(Uri.parse(url));
    return _handleResponse(response, url);
  }

  dynamic _handleResponse(http.Response response, String url) {
    LoggerUtil.logInfo('Request URL: $url');
    LoggerUtil.logInfo('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('HTTP request failed with status ${response.statusCode}');
    }
  }
}
