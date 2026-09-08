import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'app/hush_app.dart';
import 'core/logging/app_logger.dart';
import 'features/voice_notes/data/hush_audio_handler.dart';
import 'features/voice_notes/presentation/providers/duration_prefetcher.dart';
import 'features/voice_notes/presentation/providers/player_controller.dart';
import 'features/voice_notes/presentation/providers/voice_notes_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final handler = await AudioService.init(
    builder: HushAudioHandler.new,
    // Il servizio resta in foreground anche in pausa: da Android 12 un
    // servizio fermato non puo essere riavviato dal background, e la ripresa
    // dalla notifica fallirebbe.
    // Gli intervalli arrivano da `skipInterval`: sono gli stessi salti dei
    // pulsanti nel player e delle etichette tradotte, e tenerne una copia
    // separata qui vorrebbe dire che cambiandone una le altre mentono.
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.grittch.hush.playback',
      androidNotificationChannelName: 'Hush',
      androidStopForegroundOnPause: false,
      fastForwardInterval: skipInterval,
      rewindInterval: skipInterval,
    ),
  );

  final container = ProviderContainer(
    overrides: [audioHandlerProvider.overrideWithValue(handler)],
  );
  final logger = container.read(appLoggerProvider);
  container.read(voiceNoteCacheJanitorProvider);
  container.read(durationPrefetcherProvider);

  FlutterError.onError = (details) =>
      _report(logger, 'Errore del framework', details.exception, details.stack);
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    _report(logger, 'Errore non gestito', error, stackTrace);
    return true;
  };

  runApp(
    UncontrolledProviderScope(container: container, child: const HushApp()),
  );
}

/// Nei log finisce il tipo dell'errore, non il messaggio: quello di
/// `PlatformException` contiene l'URI SAF e quello di `FileSystemException` il
/// percorso della copia, cioe il nome del vocale e con chi si sta parlando.
void _report(Logger logger, String what, Object error, StackTrace? stackTrace) {
  logger.e('$what: ${error.runtimeType}', stackTrace: stackTrace);
}
