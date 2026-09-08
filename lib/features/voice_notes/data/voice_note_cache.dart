import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../../core/hashing/stable_key.dart';
import '../domain/voice_note.dart';

const _cacheFolderName = 'voice_notes';
const _maxCacheBytes = 100 * 1024 * 1024;

/// Lo sfratto costa una `stat` per file in cache. La scansione delle durate
/// copia ogni vocale della cartella, quindi controllare a ogni copia sarebbe
/// quadratico: si accumula fino a questa soglia, che limita lo sforamento del
/// tetto a pochi MB.
const _sweepThreshold = 8 * 1024 * 1024;

/// Le copie riproducibili vivono nella cache privata dell'app: sono contenuto
/// personale di altre persone, non file temporanei qualunque.
class VoiceNoteCache {
  int _bytesSinceSweep = 0;

  Future<File> fileFor(VoiceNoteId id) async {
    final directory = await _directory();
    return File('${directory.path}/${stableKey(id.storageKey)}');
  }

  /// Registra un accesso senza ricopiare, cosi lo sfratto sceglie davvero il
  /// meno usato di recente e non il meno recentemente copiato.
  Future<void> touch(File file) async {
    try {
      await file.setLastModified(DateTime.now());
    } on FileSystemException {
      // Un timestamp non aggiornabile peggiora solo l'ordine di sfratto:
      // non e un errore che l'utente debba vedere.
    }
  }

  /// Da chiamare dopo ogni copia: accumula i byte scritti e passa allo sfratto
  /// solo quando ne vale la pena.
  Future<void> registerCopy(File file, {required String keepPath}) async {
    _bytesSinceSweep += await file.length();
    if (_bytesSinceSweep < _sweepThreshold) return;
    _bytesSinceSweep = 0;
    await trim(keepPath: keepPath);
  }

  /// Mantiene la cache entro il tetto, sfrattando dal meno usato di recente.
  /// Il file in riproduzione conta nel totale ma non viene mai eliminato.
  Future<void> trim({required String keepPath}) async {
    final directory = await _directory();
    final entries = <({File file, FileStat stat})>[];

    await for (final entity in directory.list()) {
      if (entity is! File) continue;
      // La versione sincrona bloccherebbe il thread della UI per migliaia di
      // file a ogni apertura di un vocale.
      // ignore: avoid_slow_async_io
      final stat = await entity.stat();
      if (stat.type == FileSystemEntityType.notFound) continue;
      entries.add((file: entity, stat: stat));
    }

    var total = entries.fold<int>(0, (sum, entry) => sum + entry.stat.size);
    if (total <= _maxCacheBytes) return;

    final evictable =
        entries.where((entry) => entry.file.path != keepPath).toList()
          ..sort((a, b) => a.stat.modified.compareTo(b.stat.modified));

    for (final entry in evictable) {
      if (total <= _maxCacheBytes) return;
      total -= entry.stat.size;
      try {
        await entry.file.delete();
      } on FileSystemException {
        // Il file e sparito o e in uso: si passa al successivo.
      }
    }
  }

  /// Chiamato quando cambia la cartella sorgente: le copie della vecchia non
  /// servono piu e non devono restare sul dispositivo.
  Future<void> clear() async {
    final directory = await _directory();
    _bytesSinceSweep = 0;
    try {
      await directory.delete(recursive: true);
    } on FileSystemException {
      // Nulla da svuotare, o cartella gia rimossa dal sistema.
    }
  }

  Future<Directory> _directory() async {
    final base = await getApplicationCacheDirectory();
    final directory = Directory('${base.path}/$_cacheFolderName');
    await directory.create(recursive: true);
    return directory;
  }
}
