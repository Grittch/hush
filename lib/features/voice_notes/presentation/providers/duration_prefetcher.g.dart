// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration_prefetcher.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riempie le durate mancanti subito dopo la scansione della cartella, invece
/// di aspettare che l'utente apra ogni vocale. La durata finisce in Drift, cosi
/// il costo si paga una volta sola per vocale e la lista si aggiorna da se.

@ProviderFor(DurationPrefetcher)
final durationPrefetcherProvider = DurationPrefetcherProvider._();

/// Riempie le durate mancanti subito dopo la scansione della cartella, invece
/// di aspettare che l'utente apra ogni vocale. La durata finisce in Drift, cosi
/// il costo si paga una volta sola per vocale e la lista si aggiorna da se.
final class DurationPrefetcherProvider
    extends $NotifierProvider<DurationPrefetcher, void> {
  /// Riempie le durate mancanti subito dopo la scansione della cartella, invece
  /// di aspettare che l'utente apra ogni vocale. La durata finisce in Drift, cosi
  /// il costo si paga una volta sola per vocale e la lista si aggiorna da se.
  DurationPrefetcherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'durationPrefetcherProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$durationPrefetcherHash();

  @$internal
  @override
  DurationPrefetcher create() => DurationPrefetcher();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$durationPrefetcherHash() =>
    r'7917cf4a9a51bee780524386a471947260d7c99c';

/// Riempie le durate mancanti subito dopo la scansione della cartella, invece
/// di aspettare che l'utente apra ogni vocale. La durata finisce in Drift, cosi
/// il costo si paga una volta sola per vocale e la lista si aggiorna da se.

abstract class _$DurationPrefetcher extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
