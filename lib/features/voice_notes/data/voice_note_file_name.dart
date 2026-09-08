const audioExtensions = {'.opus', '.ogg', '.m4a', '.mp3', '.aac', '.wav'};

final _whatsAppPattern = RegExp(
  r'^PTT-(\d{4})(\d{2})(\d{2})-WA(\d+)\.',
  caseSensitive: false,
);

bool isAudioFileName(String fileName) {
  final dot = fileName.lastIndexOf('.');
  if (dot == -1) return false;
  return audioExtensions.contains(fileName.substring(dot).toLowerCase());
}

/// Estrae il giorno dal nome che WhatsApp assegna ai vocali
/// (`PTT-20260811-WA0001.opus`). Restituisce null per qualunque nome che non
/// segua lo schema: file rinominati a mano, audio inviati come allegato, o
/// formati di versioni future.
DateTime? dayFromFileName(String fileName) {
  final match = _whatsAppPattern.firstMatch(fileName);
  if (match == null) return null;

  final year = int.tryParse(match.group(1) ?? '');
  final month = int.tryParse(match.group(2) ?? '');
  final day = int.tryParse(match.group(3) ?? '');
  if (year == null || month == null || day == null) return null;
  if (month < 1 || month > 12 || day < 1 || day > 31) return null;

  final parsed = DateTime(year, month, day);
  if (parsed.month != month || parsed.day != day) return null;
  return parsed;
}

/// Il progressivo `WAxxxx`: ordina i vocali dentro la giornata anche quando la
/// data di modifica del file e stata riscritta.
int? sequenceFromFileName(String fileName) {
  final match = _whatsAppPattern.firstMatch(fileName);
  if (match == null) return null;
  return int.tryParse(match.group(4) ?? '');
}
