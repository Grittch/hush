import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart' show PlayerException;
import 'package:hush/core/errors/hush_exception.dart';
import 'package:hush/core/errors/hush_exception_mapper.dart';

void main() {
  group('mapErrors', () {
    test('lascia passare il risultato quando non ci sono errori', () async {
      expect(await mapErrors(() async => 42), 42);
    });

    test('non riavvolge un errore di dominio gia tipizzato', () {
      expect(
        () => mapErrors<void>(() async => throw const VoiceNoteGoneException()),
        throwsA(isA<VoiceNoteGoneException>()),
      );
    });

    test('una SecurityException di SAF diventa accesso perduto', () {
      expect(
        () => mapErrors<void>(
          () async => throw PlatformException(
            code: 'PluginError',
            message: 'java.lang.SecurityException: permission denied',
          ),
        ),
        throwsA(isA<SourceAccessLostException>()),
      );
    });

    test('un file non trovato diventa vocale sparito', () {
      expect(
        () => mapErrors<void>(
          () async => throw PlatformException(
            code: 'PluginError',
            message: 'FileNotFoundException',
          ),
        ),
        throwsA(isA<VoiceNoteGoneException>()),
      );
    });

    test('ENOSPC dal filesystem diventa spazio insufficiente', () {
      expect(
        () => mapErrors<void>(
          () async => throw const FileSystemException(
            'copy failed',
            '',
            OSError('No space left on device', 28),
          ),
        ),
        throwsA(isA<InsufficientStorageException>()),
      );
    });

    test('un fallimento del player diventa vocale non riproducibile', () {
      expect(
        () => mapErrors<void>(
          () async => throw PlayerException(0, 'decoder failed', null),
        ),
        throwsA(isA<VoiceNoteUnplayableException>()),
      );
    });

    test('errno 2 diventa vocale sparito', () {
      expect(
        () => mapErrors<void>(
          () async => throw const FileSystemException(
            'open failed',
            '',
            OSError('No such file or directory', 2),
          ),
        ),
        throwsA(isA<VoiceNoteGoneException>()),
      );
    });

    test('errno 13 diventa accesso perduto', () {
      expect(
        () => mapErrors<void>(
          () async => throw const FileSystemException(
            'open failed',
            '',
            OSError('Permission denied', 13),
          ),
        ),
        throwsA(isA<SourceAccessLostException>()),
      );
    });

    test('un timeout diventa sconosciuto, non un errore di libreria', () {
      expect(
        () => mapErrors<void>(() async => throw TimeoutException('slow')),
        throwsA(isA<UnknownHushException>()),
      );
    });

    test('un errore imprevisto diventa sconosciuto, non sfugge grezzo', () {
      expect(
        () => mapErrors<void>(() async => throw StateError('boom')),
        throwsA(isA<UnknownHushException>()),
      );
    });
  });
}
