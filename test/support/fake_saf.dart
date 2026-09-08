import 'dart:io';

import 'package:flutter/services.dart';
import 'package:saf_stream/saf_stream.dart';
import 'package:saf_util/saf_util.dart';
import 'package:saf_util/saf_util_platform_interface.dart';

SafDocumentFile safDir(String uri, String name) => SafDocumentFile(
  uri: uri,
  name: name,
  isDir: true,
  length: 0,
  lastModified: 0,
);

SafDocumentFile safFile(
  String uri,
  String name, {
  int length = 4096,
  DateTime? lastModified,
}) => SafDocumentFile(
  uri: uri,
  name: name,
  isDir: false,
  length: length,
  lastModified:
      (lastModified ?? DateTime(2026, 8, 11, 10, 30)).millisecondsSinceEpoch,
);

/// Albero di cartelle in memoria: la chiave e l'URI della cartella, il valore
/// i suoi figli.
class FakeSafUtil implements SafUtil {
  FakeSafUtil(this.tree, {this.hasPermission = true});

  final Map<String, List<SafDocumentFile>> tree;
  bool hasPermission;
  final List<String> listedUris = [];
  int maxConcurrentLists = 0;
  int _inFlight = 0;

  @override
  Future<List<SafDocumentFile>> list(String uri) async {
    listedUris.add(uri);
    _inFlight++;
    maxConcurrentLists = _inFlight > maxConcurrentLists
        ? _inFlight
        : maxConcurrentLists;
    await Future<void>.delayed(Duration.zero);
    _inFlight--;
    return tree[uri] ?? const [];
  }

  @override
  Future<bool> hasPersistedPermission(
    String uri, {
    bool checkRead = true,
    bool checkWrite = false,
  }) async => hasPermission;

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('non usato nei test: ${invocation.memberName}');
}

class FakeSafStream implements SafStream {
  final List<String> copied = [];

  @override
  Future<void> copyToLocalFile(String srcUri, String destPath) async {
    copied.add(srcUri);
    await File(destPath).writeAsBytes(Uint8List(4096));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('non usato nei test: ${invocation.memberName}');
}

/// `PlatformException` con il codice che i plugin SAF usano per gli errori.
PlatformException safFailure(String message) =>
    PlatformException(code: 'PluginError', message: message);
