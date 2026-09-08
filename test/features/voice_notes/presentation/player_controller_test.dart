import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hush/core/errors/hush_exception.dart';
import 'package:hush/core/hashing/stable_key.dart';
import 'package:hush/core/permissions/notification_permission.dart';
import 'package:hush/features/voice_notes/domain/voice_note.dart';
import 'package:hush/features/voice_notes/presentation/providers/player_controller.dart';
import 'package:hush/features/voice_notes/presentation/providers/voice_notes_providers.dart';

import '../../../support/fakes.dart';

class _FakeNotificationPermission implements NotificationPermission {
  _FakeNotificationPermission(this.status);

  NotificationPermissionStatus status;
  int openSettingsCalls = 0;

  @override
  Future<NotificationPermissionStatus> ensure() async => status;

  @override
  Future<void> openSettings() async => openSettingsCalls++;
}

void main() {
  late FakeVoiceNoteSource source;
  late FakeVoiceNotePlayer player;
  late RecordingPlaybackStateStore store;
  late _FakeNotificationPermission permission;
  late ProviderContainer container;

  PlayerController controller() =>
      container.read(playerControllerProvider.notifier);

  PlayerUiState state() => container.read(playerControllerProvider);

  setUp(() {
    source = FakeVoiceNoteSource();
    player = FakeVoiceNotePlayer();
    store = RecordingPlaybackStateStore();
    permission = _FakeNotificationPermission(
      NotificationPermissionStatus.granted,
    );
    container = ProviderContainer(
      overrides: [
        voiceNoteSourceProvider.overrideWithValue(source),
        voiceNotePlayerProvider.overrideWithValue(player),
        playbackStateStoreProvider.overrideWithValue(store),
        notificationPermissionProvider.overrideWithValue(permission),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await player.dispose();
    await store.dispose();
  });

  test('il controller sopravvive a una lettura senza osservatori', () async {
    // Con autoDispose il notifier veniva smaltito nella microtask dopo la
    // lettura, prima che il foglio del player lo osservasse: lo stato andava
    // perso e la riproduzione non partiva mai.
    final note = fakeNote();
    await controller().open(note, notificationTitle: 'Hush');
    await Future<void>.delayed(Duration.zero);

    expect(state().note, note);
    expect(player.playCalls, 1);
  });

  test('apre il vocale, lo carica e ne persiste la durata', () async {
    final note = fakeNote();
    await controller().open(note, notificationTitle: 'Hush');

    expect(player.loadedPaths, ['/cache/${note.fileName}']);
    expect(state().isLoading, isFalse);
    expect(state().duration, const Duration(seconds: 30));
    expect(store.current[note.id]?.duration, const Duration(seconds: 30));
  });

  test('non mette il nome del file nella sessione media', () async {
    final note = fakeNote();
    await controller().open(note, notificationTitle: 'Hush');

    expect(player.loadedMediaIds.single, stableKey(note.id.storageKey));
    expect(player.loadedMediaIds.single, isNot(contains(note.fileName)));
  });

  test('riprende dalla posizione salvata', () async {
    final note = fakeNote(
      progress: const PlaybackProgress(position: Duration(seconds: 12)),
    );
    await controller().open(note, notificationTitle: 'Hush');

    expect(player.lastSeek, const Duration(seconds: 12));
  });

  test('salva la posizione del vocale precedente prima di cambiare', () async {
    final first = fakeNote(fileName: 'PTT-20260811-WA0001.opus');
    final second = fakeNote(fileName: 'PTT-20260811-WA0002.opus');

    await controller().open(first, notificationTitle: 'Hush');
    player.emitPosition(const Duration(seconds: 90));
    await Future<void>.delayed(Duration.zero);
    await controller().open(second, notificationTitle: 'Hush');

    expect(
      store.saved.any(
        (entry) =>
            entry.id == first.id &&
            entry.position == const Duration(seconds: 90),
      ),
      isTrue,
      reason: 'la posizione del primo vocale non deve andare perduta',
    );
  });

  test(
    'la fine della traccia marca il vocale caricato, non quello in stato',
    () async {
      final note = fakeNote();
      await controller().open(note, notificationTitle: 'Hush');

      player.emitCompletion();
      await Future<void>.delayed(Duration.zero);

      expect(store.played, [note.id]);
      expect(state().position, Duration.zero);
    },
  );

  test('la pausa salva la posizione corrente', () async {
    final note = fakeNote();
    await controller().open(note, notificationTitle: 'Hush');

    player.emitPlaying(true);
    player.emitPosition(const Duration(seconds: 7));
    await Future<void>.delayed(Duration.zero);
    player.emitPlaying(false);
    await Future<void>.delayed(Duration.zero);

    expect(store.current[note.id]?.position, const Duration(seconds: 7));
  });

  test('un secondo tap durante il caricamento viene ignorato', () async {
    source.materializeDelay = const Duration(milliseconds: 50);
    final first = fakeNote(fileName: 'PTT-20260811-WA0001.opus');
    final second = fakeNote(fileName: 'PTT-20260811-WA0002.opus');

    final opening = controller().open(first, notificationTitle: 'Hush');
    await controller().open(second, notificationTitle: 'Hush');
    await opening;

    expect(source.materialized, [first.id]);
    expect(state().note, first);
  });

  test('seek oltre la durata si ferma alla fine', () async {
    final note = fakeNote();
    await controller().open(note, notificationTitle: 'Hush');

    player.emitPosition(const Duration(seconds: 28));
    await Future<void>.delayed(Duration.zero);
    await controller().skip(skipInterval);

    expect(player.lastSeek, const Duration(seconds: 30));
  });

  test(
    'un errore della sorgente diventa un errore tipizzato in stato',
    () async {
      source.materializeError = const VoiceNoteGoneException();
      await controller().open(fakeNote(), notificationTitle: 'Hush');

      expect(state().error, isA<VoiceNoteGoneException>());
      expect(state().isLoading, isFalse);
      expect(player.playCalls, 0);
    },
  );

  test('il permesso notifiche negato per sempre non blocca l audio', () async {
    permission.status = NotificationPermissionStatus.permanentlyDenied;
    await controller().open(fakeNote(), notificationTitle: 'Hush');

    expect(state().notificationsBlocked, isTrue);
    expect(player.playCalls, 1);
  });

  test('il cambio velocita arriva al player', () async {
    await controller().open(fakeNote(), notificationTitle: 'Hush');
    await controller().setSpeed(1.5);

    expect(player.speed, 1.5);
    expect(state().speed, 1.5);
  });
}
