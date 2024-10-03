import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? _preferences;

  static const String _keyEmail = 'email';
  static const String _keyToken = 'token';
  static const String _keyExpiresIn = 'expiresIn';

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  // Setters and Getters for Email
  static Future<void> setEmail(String? email) async {
    await _preferences?.setString(_keyEmail, email ?? '');
  }

  static String? getEmail() => _preferences?.getString(_keyEmail);


  // Setters and Getters for expiresIn
  static Future<void> setExpiresIn(String? expiresIn) async {
    await _preferences?.setString(_keyExpiresIn, expiresIn ?? '');
  }

  static String? getExpiresIn() => _preferences?.getString(_keyExpiresIn);

  // Setters and Getters for Token
  static Future<void> setToken(String? token) async {
    await _preferences?.setString(_keyToken, token ?? '');
  }

  static String? getToken() => _preferences?.getString(_keyToken);

  // Clear all stored data
  static Future<void> clear() async {
    await _preferences?.clear();
  }

  // Get all stored preferences in a map
  static Future<Map<String, String?>> getAll() async {
    return {
      _keyExpiresIn: getExpiresIn(),
      _keyEmail: getEmail(),
      _keyToken: getToken(),
    };
  }
}
