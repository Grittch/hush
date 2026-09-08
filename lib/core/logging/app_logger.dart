import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_logger.g.dart';

@Riverpod(keepAlive: true)
Logger appLogger(Ref ref) {
  final logger = Logger(
    level: kReleaseMode ? Level.warning : Level.debug,
    printer: PrettyPrinter(methodCount: 0, colors: false, printEmojis: false),
  );
  ref.onDispose(logger.close);
  return logger;
}
