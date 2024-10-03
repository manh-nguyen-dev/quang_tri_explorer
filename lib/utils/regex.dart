class Regex {
  static bool isEmail(String email) {
    RegExp regExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regExp.hasMatch(email);
  }

  static bool isPassword(String password) {
    // Password regex: At least 8 chars, one uppercase, one lowercase, one number
    RegExp regExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$',
    );
    return regExp.hasMatch(password);
  }

  static bool isStrongPassword(String password) {
    // At least 8 chars, one letter, one number, and one special character
    RegExp regExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return regExp.hasMatch(password);
  }

  static bool isValidUsername(String username) {
    // Alphanumeric characters and underscores, 3 to 20 characters long
    RegExp regExp = RegExp(
      r'^[a-zA-Z0-9_]{3,20}$',
    );
    return regExp.hasMatch(username);
  }

  static bool isPasswordAtLeast8Characters(String password) {
    return password.length >= 8;
  }

  static bool isNumericOnly(String input) {
    if (input.isEmpty) {
      return false;
    }
    return double.tryParse(input) != null;
  }

  static bool isPhoneNumber(String phoneNumber) {
    // More specific regex for phone numbers (only digits, at least 9 digits)
    RegExp regExp = RegExp(r'^\d{9,}$');
    return regExp.hasMatch(phoneNumber);
  }

  static RegExp regExpYoutube = RegExp(
    r'^(http(s)?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.+',
    caseSensitive: false,
  );

  static bool isValidUrl(String url) {
    RegExp regExp = RegExp(
      r'^(https?:\/\/)?([\da-z.-]+)\.([a-z.]{2,6})([\/\w .-]*)*\/?$',
      caseSensitive: false,
    );
    return regExp.hasMatch(url);
  }

  static bool isValidHexColor(String color) {
    RegExp regExp = RegExp(
      r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$',
    );
    return regExp.hasMatch(color);
  }
}