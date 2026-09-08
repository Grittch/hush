import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/hush_exception.dart';
import '../../../../core/hashing/stable_key.dart';
import '../../../../core/permissions/notification_permission.dart';
import '../../domain/playback_state_store.dart';
import '../../domain/voice_note.dart';
import 'voice_notes_providers.dart';

part 'player_controller.freezed.dart';
part 'player_controller.g.dart';

const skipInterval = Duration(seconds: 10);
const availableSpeeds = [0.75, 1.0, 1.25, 1.5, 2.0];

@freezed
abstract class PlayerUiState with _$PlayerUiState {
  const factory PlayerUiState({
    VoiceNote? note,
    @Default(false) bool isLoading,
    @Default(false) bool isPlaying,
    @Default(Duration.zero) Duration position,
    Duration? duration,
    @Default(1.0) double speed,
    @Default(false) bool notificationsBlocked,
    HushException? error,
  }) = _PlayerUiState;

  const PlayerUiState._();

  bool get hasNote => note != null;
}

/// `keepAlive` non e un dettaglio: l'audio sopravvive per progetto al foglio
/// che l'ha aperto (il servizio resta in foreground), quindi il controller che
/// lo comanda non puo avere il ciclo di vita di un bottom sheet. Con
/// autoDispose veniva smaltito nella microtask dopo il `ref.read` della lista,
/// prima che il foglio lo osservasse: il player non partiva mai.
@Riverpod(keepAlive: true)
class PlayerController extends _$PlayerController {
  int _openToken = 0;

  /// Il vocale che il player tiene davvero caricato. Gli eventi degli stream
  /// vanno legati a questo, non a `state.note`: durante un cambio di traccia i
  /// due divergono, e leggere lo stato marcherebbe come ascoltato il vocale
  /// sbagliato.
  VoiceNoteId? _loadedId;

  @override
  PlayerUiState build() {
    final player = ref.watch(voiceNotePlayerProvider);
    final subscriptions = <StreamSubscription<Object?>>[
      player.positionStream.listen(_onPosition),
      player.playingStream.listen(_onPlaying),
      player.completionStream.listen(_onCompleted),
    ];
    ref.onDispose(() {
      for (final subscription in subscriptions) {
        unawaited(subscription.cancel());
      }
    });
    return const PlayerUiState();
  }

  Future<void> open(VoiceNote note, {required String notificationTitle}) async {
    if (state.isLoading) return;

    final token = ++_openToken;

    // Lo stato del vocale che stiamo lasciando va catturato adesso, perche
    // `isLoading` deve alzarsi prima di qualunque `await`: altrimenti un
    // secondo tap passa la guardia e due caricamenti si sovrappongono.
    final previousId = _loadedId;
    final previousPosition = state.position;
    final previousDuration = state.duration;

    state = PlayerUiState(
      note: note,
      isLoading: true,
      position: note.resumePosition,
      duration: note.duration,
      speed: state.speed,
      notificationsBlocked: state.notificationsBlocked,
    );

    if (previousId != null) {
      await _guard(
        () => _store.saveProgress(
          id: previousId,
          position: previousPosition,
          duration: previousDuration,
        ),
      );
    }

    final source = ref.read(voiceNoteSourceProvider);
    if (source == null) {
      state = state.copyWith(
        isLoading: false,
        error: const SourceAccessLostException(),
      );
      return;
    }

    try {
      final path = await source.materialize(note);
      if (token != _openToken) return;

      await _requestNotificationPermission();
      if (token != _openToken) return;

      final player = ref.read(voiceNotePlayerProvider);
      final duration = await player.load(
        path: path,
        mediaId: stableKey(note.id.storageKey),
        title: notificationTitle,
        duration: note.duration,
      );
      if (token != _openToken) return;

      _loadedId = note.id;
      await player.setSpeed(state.speed);
      if (note.resumePosition > Duration.zero) {
        await player.seek(note.resumePosition);
      }
      state = state.copyWith(
        isLoading: false,
        duration: duration ?? note.duration,
      );
      if (duration != null) {
        await _store.saveProgress(
          id: note.id,
          position: note.resumePosition,
          duration: duration,
        );
      }
      await player.play();
    } on HushException catch (error) {
      if (token != _openToken) return;
      state = state.copyWith(isLoading: false, error: error);
    }
  }

  Future<void> togglePlay() async {
    if (_loadedId == null) return;
    final player = ref.read(voiceNotePlayerProvider);
    try {
      if (state.isPlaying) {
        await player.pause();
      } else {
        await player.play();
      }
    } on HushException catch (error) {
      state = state.copyWith(error: error);
    }
  }

  Future<void> seek(Duration position) async {
    if (_loadedId == null) return;
    try {
      await ref.read(voiceNotePlayerProvider).seek(position);
    } on HushException catch (error) {
      state = state.copyWith(error: error);
    }
  }

  Future<void> skip(Duration offset) {
    final target = state.position + offset;
    final duration = state.duration;
    if (target.isNegative) return seek(Duration.zero);
    if (duration != null && target > duration) return seek(duration);
    return seek(target);
  }

  Future<void> setSpeed(double speed) async {
    state = state.copyWith(speed: speed);
    try {
      await ref.read(voiceNotePlayerProvider).setSpeed(speed);
    } on HushException catch (error) {
      state = state.copyWith(error: error);
    }
  }

  Future<void> openSystemSettings() =>
      ref.read(notificationPermissionProvider).openSettings();

  void dismissError() => state = state.copyWith(error: null);

  void _onPosition(Duration position) {
    if (_loadedId == null) return;
    state = state.copyWith(position: position);
  }

  Future<void> _onPlaying(bool playing) async {
    if (state.isPlaying == playing) return;
    state = state.copyWith(isPlaying: playing);
    // La posizione si salva quando la riproduzione si ferma, non a ogni tick:
    // altrimenti sarebbe una scrittura al secondo per tutto l'ascolto.
    if (!playing) await _persistPosition();
  }

  Future<void> _onCompleted(void _) async {
    final id = _loadedId;
    if (id == null) return;
    state = state.copyWith(isPlaying: false, position: Duration.zero);
    await _guard(() => _store.markPlayed(id));
  }

  Future<void> _persistPosition() async {
    final id = _loadedId;
    if (id == null) return;
    await _guard(
      () => _store.saveProgress(
        id: id,
        position: state.position,
        duration: state.duration,
      ),
    );
  }

  /// Chiesto alla prima riproduzione, non all'avvio. Se negato l'audio va
  /// comunque: si perdono solo i controlli in notifica.
  Future<void> _requestNotificationPermission() async {
    final status = await ref.read(notificationPermissionProvider).ensure();
    state = state.copyWith(
      notificationsBlocked:
          status == NotificationPermissionStatus.permanentlyDenied,
    );
  }

  Future<void> _guard(Future<void> Function() write) async {
    try {
      await write();
    } on HushException catch (error) {
      state = state.copyWith(error: error);
    }
  }

  PlaybackStateStore get _store => ref.read(playbackStateStoreProvider);
}
