import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/saf/saf_providers.dart';
import '../../../../core/settings/app_settings_controller.dart';
import '../../data/drift_playback_state_store.dart';
import '../../data/hush_audio_handler.dart';
import '../../data/hush_database.dart';
import '../../data/just_audio_duration_reader.dart';
import '../../data/saf_voice_note_source.dart';
import '../../data/voice_note_cache.dart';
import '../../domain/playback_state_store.dart';
import '../../domain/voice_note.dart';
import '../../domain/voice_note_duration_reader.dart';
import '../../domain/voice_note_group.dart';
import '../../domain/voice_note_player.dart';
import '../../domain/voice_note_source.dart';

part 'voice_notes_providers.g.dart';

@Riverpod(keepAlive: true)
VoiceNoteCache voiceNoteCache(Ref ref) => VoiceNoteCache();

@Riverpod(keepAlive: true)
HushDatabase hushDatabase(Ref ref) {
  final database = HushDatabase();
  ref.onDispose(database.close);
  return database;
}

@Riverpod(keepAlive: true)
PlaybackStateStore playbackStateStore(Ref ref) =>
    DriftPlaybackStateStore(ref.watch(hushDatabaseProvider));

/// Sovrascritto in `main` con l'istanza restituita da `AudioService.init`:
/// l'handler deve essere costruito dal servizio, non da Riverpod.
@Riverpod(keepAlive: true)
HushAudioHandler audioHandler(Ref ref) => throw UnimplementedError(
  'Sovrascrivi audioHandlerProvider con il risultato di AudioService.init '
  '(vedi main.dart)',
);

@Riverpod(keepAlive: true)
VoiceNotePlayer voiceNotePlayer(Ref ref) => ref.watch(audioHandlerProvider);

@Riverpod(keepAlive: true)
VoiceNoteDurationReader durationReader(Ref ref) {
  final reader = JustAudioDurationReader();
  ref.onDispose(reader.dispose);
  return reader;
}

@riverpod
VoiceNoteSource? voiceNoteSource(Ref ref) {
  final folderUri = ref
      .watch(appSettingsControllerProvider)
      .value
      ?.sourceFolderUri;
  if (folderUri == null) return null;
  return SafVoiceNoteSource(
    ref.watch(safUtilProvider),
    ref.watch(safStreamProvider),
    ref.watch(voiceNoteCacheProvider),
    folderUri: folderUri,
  );
}

/// Le copie in cache appartengono alla cartella da cui vengono: quando
/// l'utente ne sceglie un'altra non servono piu, e sono contenuto personale di
/// altre persone che non deve restare sul dispositivo.
@Riverpod(keepAlive: true)
void voiceNoteCacheJanitor(Ref ref) {
  ref.listen(appSettingsControllerProvider, (previous, next) {
    final previousUri = previous?.value?.sourceFolderUri;
    final nextUri = next.value?.sourceFolderUri;
    if (previousUri == null || previousUri == nextUri) return;
    unawaited(ref.read(voiceNoteCacheProvider).clear());
  });
}

@riverpod
Stream<Map<VoiceNoteId, PlaybackProgress>> playbackProgress(Ref ref) =>
    ref.watch(playbackStateStoreProvider).watchAll();

@riverpod
Future<List<VoiceNote>> sourceNotes(Ref ref) async {
  final source = ref.watch(voiceNoteSourceProvider);
  if (source == null) return const [];
  return source.listNotes();
}

@riverpod
Future<List<VoiceNoteGroup>> voiceNoteGroups(Ref ref) async {
  final notes = await ref.watch(sourceNotesProvider.future);
  final progress = await ref.watch(playbackProgressProvider.future);
  return groupByDay(notes, progress);
}
