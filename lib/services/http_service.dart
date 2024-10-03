import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/logger_util.dart';
import 'shared_pref.dart';

class HttpService {
  final String baseUrl = "https://74explorer.vercel.app/api";
  final Function? onUnauthorized;

  HttpService({this.onUnauthorized});

  Future<dynamic> get(String endpoint) async {
    final token = SharedPref.getToken();
    final url = '$baseUrl/$endpoint';

    if (_isTokenExpired()) {
      _handleUnauthorized();
      return null;
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    return _handleResponse(response, url);
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    final url = '$baseUrl/$endpoint';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized access');
    } else {
      throw Exception('HTTP request failed with status ${response.statusCode}');
    }
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    final token = SharedPref.getToken();
    final url = '$baseUrl/$endpoint';

    if (_isTokenExpired()) {
      _handleUnauthorized();
      return null;
    }

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    return _handleResponse(response, url);
  }

  Future<dynamic> delete(String endpoint) async {
    final token = SharedPref.getToken();
    final url = '$baseUrl/$endpoint';

    if (_isTokenExpired()) {
      _handleUnauthorized();
      return null;
    }

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    return _handleResponse(response, url);
  }

  dynamic _handleResponse(http.Response response, String url) {
    LoggerUtil.logInfo('Request URL: $url');
    LoggerUtil.logInfo('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized access');
    } else {
      throw Exception('HTTP request failed with status ${response.statusCode}');
    }
  }

  bool _isTokenExpired() {
    final expiresIn = SharedPref.getExpiresIn();
    if (expiresIn == null || expiresIn.isEmpty) return true;

    final expirationDate = DateTime.tryParse(expiresIn);
    return expirationDate == null || expirationDate.isBefore(DateTime.now());
  }

  void _handleUnauthorized() {
    SharedPref.clear();
    LoggerUtil.logInfo('Redirecting to login due to unauthorized access.');
    onUnauthorized?.call();
  }
}
