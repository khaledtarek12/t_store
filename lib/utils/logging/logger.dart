import 'package:logger/logger.dart';

class TLoggerHelper {
  static final Logger _togger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );

  static void debug(String message) {
    _togger.d(message);
  }

  static void info(String message) {
    _togger.i(message);
  }

  static void warning(String message) {
    _togger.w(message);
  }

  static void error(String message, [dynamic error]) {
    _togger.e(message, error: error, stackTrace: StackTrace.current);
  }
}
