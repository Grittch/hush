// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_notes_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(voiceNoteCache)
final voiceNoteCacheProvider = VoiceNoteCacheProvider._();

final class VoiceNoteCacheProvider
    extends $FunctionalProvider<VoiceNoteCache, VoiceNoteCache, VoiceNoteCache>
    with $Provider<VoiceNoteCache> {
  VoiceNoteCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceNoteCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceNoteCacheHash();

  @$internal
  @override
  $ProviderElement<VoiceNoteCache> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VoiceNoteCache create(Ref ref) {
    return voiceNoteCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceNoteCache value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceNoteCache>(value),
    );
  }
}

String _$voiceNoteCacheHash() => r'69768e981a8bd0761a58a028284a82f83a16a204';

@ProviderFor(hushDatabase)
final hushDatabaseProvider = HushDatabaseProvider._();

final class HushDatabaseProvider
    extends $FunctionalProvider<HushDatabase, HushDatabase, HushDatabase>
    with $Provider<HushDatabase> {
  HushDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hushDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hushDatabaseHash();

  @$internal
  @override
  $ProviderElement<HushDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HushDatabase create(Ref ref) {
    return hushDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HushDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HushDatabase>(value),
    );
  }
}

String _$hushDatabaseHash() => r'df1cd196deb9d7c117a35d91844aafdca891c1db';

@ProviderFor(playbackStateStore)
final playbackStateStoreProvider = PlaybackStateStoreProvider._();

final class PlaybackStateStoreProvider
    extends
        $FunctionalProvider<
          PlaybackStateStore,
          PlaybackStateStore,
          PlaybackStateStore
        >
    with $Provider<PlaybackStateStore> {
  PlaybackStateStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playbackStateStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playbackStateStoreHash();

  @$internal
  @override
  $ProviderElement<PlaybackStateStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlaybackStateStore create(Ref ref) {
    return playbackStateStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaybackStateStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaybackStateStore>(value),
    );
  }
}

String _$playbackStateStoreHash() =>
    r'96716ff6973412b3a68ba2b6a211e8bcd3931c2d';

/// Sovrascritto in `main` con l'istanza restituita da `AudioService.init`:
/// l'handler deve essere costruito dal servizio, non da Riverpod.

@ProviderFor(audioHandler)
final audioHandlerProvider = AudioHandlerProvider._();

/// Sovrascritto in `main` con l'istanza restituita da `AudioService.init`:
/// l'handler deve essere costruito dal servizio, non da Riverpod.

final class AudioHandlerProvider
    extends
        $FunctionalProvider<
          HushAudioHandler,
          HushAudioHandler,
          HushAudioHandler
        >
    with $Provider<HushAudioHandler> {
  /// Sovrascritto in `main` con l'istanza restituita da `AudioService.init`:
  /// l'handler deve essere costruito dal servizio, non da Riverpod.
  AudioHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioHandlerHash();

  @$internal
  @override
  $ProviderElement<HushAudioHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HushAudioHandler create(Ref ref) {
    return audioHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HushAudioHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HushAudioHandler>(value),
    );
  }
}

String _$audioHandlerHash() => r'3863ee268be004c2202645e4c601f00561d4485a';

@ProviderFor(voiceNotePlayer)
final voiceNotePlayerProvider = VoiceNotePlayerProvider._();

final class VoiceNotePlayerProvider
    extends
        $FunctionalProvider<VoiceNotePlayer, VoiceNotePlayer, VoiceNotePlayer>
    with $Provider<VoiceNotePlayer> {
  VoiceNotePlayerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceNotePlayerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceNotePlayerHash();

  @$internal
  @override
  $ProviderElement<VoiceNotePlayer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VoiceNotePlayer create(Ref ref) {
    return voiceNotePlayer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceNotePlayer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceNotePlayer>(value),
    );
  }
}

String _$voiceNotePlayerHash() => r'09b99c05488bbee3ae92fd8119d6d8a1de38a73c';

@ProviderFor(durationReader)
final durationReaderProvider = DurationReaderProvider._();

final class DurationReaderProvider
    extends
        $FunctionalProvider<
          VoiceNoteDurationReader,
          VoiceNoteDurationReader,
          VoiceNoteDurationReader
        >
    with $Provider<VoiceNoteDurationReader> {
  DurationReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'durationReaderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$durationReaderHash();

  @$internal
  @override
  $ProviderElement<VoiceNoteDurationReader> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VoiceNoteDurationReader create(Ref ref) {
    return durationReader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceNoteDurationReader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceNoteDurationReader>(value),
    );
  }
}

String _$durationReaderHash() => r'cb3fe0911afced2d9ff5cb438fee25710d17879e';

@ProviderFor(voiceNoteSource)
final voiceNoteSourceProvider = VoiceNoteSourceProvider._();

final class VoiceNoteSourceProvider
    extends
        $FunctionalProvider<
          VoiceNoteSource?,
          VoiceNoteSource?,
          VoiceNoteSource?
        >
    with $Provider<VoiceNoteSource?> {
  VoiceNoteSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceNoteSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceNoteSourceHash();

  @$internal
  @override
  $ProviderElement<VoiceNoteSource?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VoiceNoteSource? create(Ref ref) {
    return voiceNoteSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceNoteSource? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceNoteSource?>(value),
    );
  }
}

String _$voiceNoteSourceHash() => r'5a09fa259fa36f8cad235f552f7818356bbe9376';

/// Le copie in cache appartengono alla cartella da cui vengono: quando
/// l'utente ne sceglie un'altra non servono piu, e sono contenuto personale di
/// altre persone che non deve restare sul dispositivo.

@ProviderFor(voiceNoteCacheJanitor)
final voiceNoteCacheJanitorProvider = VoiceNoteCacheJanitorProvider._();

/// Le copie in cache appartengono alla cartella da cui vengono: quando
/// l'utente ne sceglie un'altra non servono piu, e sono contenuto personale di
/// altre persone che non deve restare sul dispositivo.

final class VoiceNoteCacheJanitorProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Le copie in cache appartengono alla cartella da cui vengono: quando
  /// l'utente ne sceglie un'altra non servono piu, e sono contenuto personale di
  /// altre persone che non deve restare sul dispositivo.
  VoiceNoteCacheJanitorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceNoteCacheJanitorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceNoteCacheJanitorHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return voiceNoteCacheJanitor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$voiceNoteCacheJanitorHash() =>
    r'ee567999b02fb6447f5238eba573d96561d2fc13';

@ProviderFor(playbackProgress)
final playbackProgressProvider = PlaybackProgressProvider._();

final class PlaybackProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<VoiceNoteId, PlaybackProgress>>,
          Map<VoiceNoteId, PlaybackProgress>,
          Stream<Map<VoiceNoteId, PlaybackProgress>>
        >
    with
        $FutureModifier<Map<VoiceNoteId, PlaybackProgress>>,
        $StreamProvider<Map<VoiceNoteId, PlaybackProgress>> {
  PlaybackProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playbackProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playbackProgressHash();

  @$internal
  @override
  $StreamProviderElement<Map<VoiceNoteId, PlaybackProgress>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<VoiceNoteId, PlaybackProgress>> create(Ref ref) {
    return playbackProgress(ref);
  }
}

String _$playbackProgressHash() => r'8299efc18dde0a16d1686a2bdcc6d953edb97a92';

@ProviderFor(sourceNotes)
final sourceNotesProvider = SourceNotesProvider._();

final class SourceNotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VoiceNote>>,
          List<VoiceNote>,
          FutureOr<List<VoiceNote>>
        >
    with $FutureModifier<List<VoiceNote>>, $FutureProvider<List<VoiceNote>> {
  SourceNotesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sourceNotesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sourceNotesHash();

  @$internal
  @override
  $FutureProviderElement<List<VoiceNote>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VoiceNote>> create(Ref ref) {
    return sourceNotes(ref);
  }
}

String _$sourceNotesHash() => r'2ebfaac39e6e601746aec9f60f3fcda211c71c3a';

@ProviderFor(voiceNoteGroups)
final voiceNoteGroupsProvider = VoiceNoteGroupsProvider._();

final class VoiceNoteGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VoiceNoteGroup>>,
          List<VoiceNoteGroup>,
          FutureOr<List<VoiceNoteGroup>>
        >
    with
        $FutureModifier<List<VoiceNoteGroup>>,
        $FutureProvider<List<VoiceNoteGroup>> {
  VoiceNoteGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceNoteGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceNoteGroupsHash();

  @$internal
  @override
  $FutureProviderElement<List<VoiceNoteGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VoiceNoteGroup>> create(Ref ref) {
    return voiceNoteGroups(ref);
  }
}

String _$voiceNoteGroupsHash() => r'5a02fa9e733e630b3b0566e4c8ad4ba23737edc3';
