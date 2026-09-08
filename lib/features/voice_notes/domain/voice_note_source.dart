import 'voice_note.dart';

abstract interface class VoiceNoteSource {
  Future<List<VoiceNote>> listNotes();

  /// Rende il vocale riproducibile restituendo un percorso su file locale.
  Future<String> materialize(VoiceNote note);
}
