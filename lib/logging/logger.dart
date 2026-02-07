import 'dart:developer' as dev;

class Logger {
  static void error(String message, Object exception) {
    LogHandler.handleLog(message, LogLevel.error);
  }

  static void debug(String message, {Object? exception}) {
    LogHandler.handleLog(message, LogLevel.debug);
  }
}

enum LogLevel { error, debug }

class LogHandler {
  static void handleLog(String log, LogLevel logLevel, {StackTrace? trace}) {
    switch (logLevel) {
      case LogLevel.error:
        writeToTerminal(log, colorMod: "\x1b[31m", stackTrace: trace);
        break;
      default:
        writeToTerminal(
          log,
          colorMod: "\x1b[32m",
          stackTrace: trace ?? StackTrace.fromString(""),
        );
    }
  }

  static void writeToTerminal(
    String log, {
    StackTrace? stackTrace,
    String? colorMod,
  }) {
    stackTrace ??= StackTrace.current;
    List<String> lines = stackTrace.toString().split("\n");
    dev.log("$colorMod| $log");
    dev.log("$colorMod--------------------------------------");
    if (stackTrace.toString() != "") {
      for (var line in lines) {
        dev.log("$colorMod| $line");
      }
      dev.log("$colorMod--------------------------------------");
    }
  }
}
