// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `keepAlive` non e un dettaglio: l'audio sopravvive per progetto al foglio
/// che l'ha aperto (il servizio resta in foreground), quindi il controller che
/// lo comanda non puo avere il ciclo di vita di un bottom sheet. Con
/// autoDispose veniva smaltito nella microtask dopo il `ref.read` della lista,
/// prima che il foglio lo osservasse: il player non partiva mai.

@ProviderFor(PlayerController)
final playerControllerProvider = PlayerControllerProvider._();

/// `keepAlive` non e un dettaglio: l'audio sopravvive per progetto al foglio
/// che l'ha aperto (il servizio resta in foreground), quindi il controller che
/// lo comanda non puo avere il ciclo di vita di un bottom sheet. Con
/// autoDispose veniva smaltito nella microtask dopo il `ref.read` della lista,
/// prima che il foglio lo osservasse: il player non partiva mai.
final class PlayerControllerProvider
    extends $NotifierProvider<PlayerController, PlayerUiState> {
  /// `keepAlive` non e un dettaglio: l'audio sopravvive per progetto al foglio
  /// che l'ha aperto (il servizio resta in foreground), quindi il controller che
  /// lo comanda non puo avere il ciclo di vita di un bottom sheet. Con
  /// autoDispose veniva smaltito nella microtask dopo il `ref.read` della lista,
  /// prima che il foglio lo osservasse: il player non partiva mai.
  PlayerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerControllerHash();

  @$internal
  @override
  PlayerController create() => PlayerController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerUiState>(value),
    );
  }
}

String _$playerControllerHash() => r'87dc89e21fe3dc339c46a188f14bb2cc7307427e';

/// `keepAlive` non e un dettaglio: l'audio sopravvive per progetto al foglio
/// che l'ha aperto (il servizio resta in foreground), quindi il controller che
/// lo comanda non puo avere il ciclo di vita di un bottom sheet. Con
/// autoDispose veniva smaltito nella microtask dopo il `ref.read` della lista,
/// prima che il foglio lo osservasse: il player non partiva mai.

abstract class _$PlayerController extends $Notifier<PlayerUiState> {
  PlayerUiState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PlayerUiState, PlayerUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlayerUiState, PlayerUiState>,
              PlayerUiState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
