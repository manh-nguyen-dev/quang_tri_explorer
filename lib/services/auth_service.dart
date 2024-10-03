import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

import 'shared_pref.dart';
import 'http_service.dart';

class AuthService {
  final HttpService _httpService;

  AuthService(this._httpService);

  Future<Response> loginUser(String email, String password) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };

      final response = await _httpService.post('login', data);

      if (response.statusCode == 200) {
        log('Login successful: ${response.body}');
        final responseData = jsonDecode(response.body);

        await SharedPref.setToken(responseData['token']);
        await SharedPref.setEmail(responseData['email']);
        await SharedPref.setExpiresIn(responseData['expiresIn']);
      } else {
        throw Exception('Invalid response or missing token');
      }

      return response;

    } catch (e) {
      log('Error during login: $e');
      rethrow;
    }
  }



  Future<Response> registerUser(String email, String password) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };

      final response = await _httpService.post('register', data);

      if (response != null && response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        log('Registration successful: ${responseData['message']}');
      } else {
        throw Exception('Invalid response or missing token');
      }

      return response;

    } catch (e) {
      log('Error during registration: $e');
      rethrow;
    }
  }
}
