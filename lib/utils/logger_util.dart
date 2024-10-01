import 'package:flutter/foundation.dart';

class LoggerUtil {
  static void logInfo(String message) {
    if (kDebugMode) {
      print("INFO: $message");
    }
  }

  static void logError(String message) {
    if (kDebugMode) {
      print("ERROR: $message");
    }
  }
}
