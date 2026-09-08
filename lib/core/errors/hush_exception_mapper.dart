import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import 'hush_exception.dart';

/// Punto unico di traduzione: nessuna eccezione di libreria esce dal data
/// layer nella sua forma originale.
Future<T> mapErrors<T>(Future<T> Function() operation) async {
  try {
    return await operation();
  } on HushException {
    rethrow;
  } on PlatformException catch (error) {
    throw _fromPlatform(error);
  } on PlayerException catch (_) {
    throw const VoiceNoteUnplayableException();
  } on PlayerInterruptedException catch (_) {
    throw const VoiceNoteUnplayableException();
  } on FileSystemException catch (error) {
    throw _fromFileSystem(error);
  } on DriftWrappedException catch (_) {
    throw const LocalStoreException();
  } on InvalidDataException catch (_) {
    throw const LocalStoreException();
  } on TimeoutException catch (_) {
    throw const UnknownHushException();
  } catch (_) {
    throw const UnknownHushException();
  }
}

HushException _fromPlatform(PlatformException error) {
  final detail = '${error.code} ${error.message ?? ''}'.toLowerCase();
  if (detail.contains('securityexception') || detail.contains('permission')) {
    return const SourceAccessLostException();
  }
  if (detail.contains('filenotfound') || detail.contains('no such file')) {
    return const VoiceNoteGoneException();
  }
  if (detail.contains('enospc') || detail.contains('no space')) {
    return const InsufficientStorageException();
  }
  return const UnknownHushException();
}

HushException _fromFileSystem(FileSystemException error) {
  const noSpaceErrno = 28;
  const notFoundErrno = 2;
  const accessDeniedErrno = 13;
  return switch (error.osError?.errorCode) {
    noSpaceErrno => const InsufficientStorageException(),
    notFoundErrno => const VoiceNoteGoneException(),
    accessDeniedErrno => const SourceAccessLostException(),
    _ => const UnknownHushException(),
  };
}
