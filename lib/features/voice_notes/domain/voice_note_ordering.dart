import 'voice_note.dart';

/// Dal piu recente al piu vecchio: prima il giorno, poi il progressivo di
/// WhatsApp dentro la giornata. E l'unico ordine che l'app usa, sia per la
/// lista sia per decidere quali vocali misurare per primi.
int compareNewestFirst(VoiceNote a, VoiceNote b) {
  final byDay = b.day.compareTo(a.day);
  if (byDay != 0) return byDay;
  return b.orderWithinDay.compareTo(a.orderWithinDay);
}

List<VoiceNote> newestFirst(Iterable<VoiceNote> notes) =>
    notes.toList()..sort(compareNewestFirst);
