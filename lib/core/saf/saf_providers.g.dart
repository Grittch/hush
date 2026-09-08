// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saf_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(safUtil)
final safUtilProvider = SafUtilProvider._();

final class SafUtilProvider
    extends $FunctionalProvider<SafUtil, SafUtil, SafUtil>
    with $Provider<SafUtil> {
  SafUtilProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'safUtilProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$safUtilHash();

  @$internal
  @override
  $ProviderElement<SafUtil> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SafUtil create(Ref ref) {
    return safUtil(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SafUtil value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SafUtil>(value),
    );
  }
}

String _$safUtilHash() => r'4b8b0577d9fe3ac18f910c51b7ade119406bca02';

@ProviderFor(safStream)
final safStreamProvider = SafStreamProvider._();

final class SafStreamProvider
    extends $FunctionalProvider<SafStream, SafStream, SafStream>
    with $Provider<SafStream> {
  SafStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'safStreamProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$safStreamHash();

  @$internal
  @override
  $ProviderElement<SafStream> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SafStream create(Ref ref) {
    return safStream(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SafStream value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SafStream>(value),
    );
  }
}

String _$safStreamHash() => r'a9395f2bf3fa82731cee9527edefae8d7b4a4bac';

@ProviderFor(sourceFolderPicker)
final sourceFolderPickerProvider = SourceFolderPickerProvider._();

final class SourceFolderPickerProvider
    extends
        $FunctionalProvider<
          SourceFolderPicker,
          SourceFolderPicker,
          SourceFolderPicker
        >
    with $Provider<SourceFolderPicker> {
  SourceFolderPickerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sourceFolderPickerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sourceFolderPickerHash();

  @$internal
  @override
  $ProviderElement<SourceFolderPicker> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SourceFolderPicker create(Ref ref) {
    return sourceFolderPicker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SourceFolderPicker value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SourceFolderPicker>(value),
    );
  }
}

String _$sourceFolderPickerHash() =>
    r'11700fc09cac9ee943aedc76dd7d0e6de47d7112';
