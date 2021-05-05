import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class SupremeLogger extends Logger {
  final String className;

  SupremeLogger(this.className);

  @override
  void log(Level level, message, [error, StackTrace? stackTrace]) {
    var color = PrettyPrinter.levelColors[level];
    var emoji = PrettyPrinter.levelEmojis[level];

    debugPrint(color!('$emoji $className - $message'));
  }
}
