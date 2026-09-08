import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/theme.dart';
import '../../../core/errors/hush_exception.dart';
import '../../../core/errors/hush_exception_message.dart';
import '../../../core/saf/saf_providers.dart';
import '../../../core/settings/app_settings_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/presentation/settings_screen.dart';
import '../domain/voice_note.dart';
import '../domain/voice_note_group.dart';
import 'providers/player_controller.dart';
import 'providers/voice_notes_providers.dart';
import 'widgets/player_sheet.dart';
import 'widgets/voice_note_tile.dart';

class VoiceNotesScreen extends ConsumerWidget {
  const VoiceNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final groups = ref.watch(voiceNoteGroupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(sourceNotesProvider),
            icon: const Icon(Icons.refresh),
            tooltip: l10n.listRefresh,
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
            ),
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.settingsTitle,
          ),
        ],
      ),
      // Un refresh non deve sostituire la lista con uno spinner: finche c'e un
      // valore precedente lo si tiene a schermo.
      body: switch (groups) {
        AsyncValue<List<VoiceNoteGroup>>(:final value?) =>
          value.isEmpty ? const _EmptyView() : _GroupedList(groups: value),
        AsyncValue<List<VoiceNoteGroup>>(:final error?) => _ErrorView(
          error: error,
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

sealed class _Row {
  const _Row();
}

final class _HeaderRow extends _Row {
  const _HeaderRow(this.day, {required this.isFirst});

  final DateTime day;
  final bool isFirst;
}

final class _NoteRow extends _Row {
  const _NoteRow(this.note);

  final VoiceNote note;
}

class _GroupedList extends ConsumerWidget {
  const _GroupedList({required this.groups});

  final List<VoiceNoteGroup> groups;

  /// La lista viene appiattita in un indice unico: costruire ogni gruppo come
  /// `Column` istanzierebbe tutte le sue tile in un frame, e una giornata puo
  /// contenerne centinaia.
  List<_Row> get _rows => [
    for (final (index, group) in groups.indexed) ...[
      _HeaderRow(group.day, isFirst: index == 0),
      for (final note in group.notes) _NoteRow(note),
    ],
  ];

  Future<void> _open(BuildContext context, WidgetRef ref, VoiceNote note) {
    // Il caricamento procede mentre il foglio si apre: l'utente vede subito
    // i controlli, con lo stato di attesa dentro il player.
    unawaited(
      ref
          .read(playerControllerProvider.notifier)
          .open(note, notificationTitle: AppLocalizations.of(context).appTitle),
    );
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => const PlayerSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = Theme.of(context).tokens;
    final rows = _rows;

    return RefreshIndicator(
      onRefresh: () => ref.refresh(sourceNotesProvider.future),
      child: ListView.builder(
        padding: EdgeInsets.all(tokens.gap),
        itemCount: rows.length,
        itemBuilder: (context, index) => switch (rows[index]) {
          _HeaderRow(:final day, :final isFirst) => Padding(
            padding: EdgeInsets.only(
              top: isFirst ? 0 : tokens.gapLarge,
              bottom: tokens.gapSmall,
            ),
            child: Text(
              _dayLabel(context, day),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          _NoteRow(:final note) => Padding(
            padding: EdgeInsets.only(bottom: tokens.gapSmall),
            child: VoiceNoteTile(
              key: ValueKey(note.id.storageKey),
              note: note,
              onTap: () => unawaited(_open(context, ref, note)),
            ),
          ),
        },
      ),
    );
  }

  String _dayLabel(BuildContext context, DateTime day) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    // Differenza calcolata su date civili: fra due mezzanotti locali passano
    // 23 o 25 ore quando scatta l'ora legale, e una `Duration` sbaglierebbe.
    final difference = DateTime.utc(
      now.year,
      now.month,
      now.day,
    ).difference(DateTime.utc(day.year, day.month, day.day)).inDays;
    if (difference == 0) return l10n.groupToday;
    if (difference == 1) return l10n.groupYesterday;
    return DateFormat.yMMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(day);
  }
}

class _EmptyView extends ConsumerWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return _CenteredMessage(
      icon: Icons.inbox_outlined,
      title: l10n.listEmptyTitle,
      body: l10n.listEmptyBody,
      action: FilledButton.tonal(
        onPressed: () => ref.invalidate(sourceNotesProvider),
        child: Text(l10n.listRefresh),
      ),
    );
  }
}

class _ErrorView extends ConsumerStatefulWidget {
  const _ErrorView({required this.error});

  final Object error;

  @override
  ConsumerState<_ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends ConsumerState<_ErrorView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = widget.error;
    final isAccessLost = current is SourceAccessLostException;
    final message = current is HushException
        ? current.localized(l10n)
        : l10n.errorUnknown;

    return _CenteredMessage(
      icon: isAccessLost ? Icons.folder_off_outlined : Icons.error_outline,
      title: isAccessLost ? l10n.accessLostTitle : l10n.errorUnknown,
      body: message,
      action: FilledButton(
        onPressed: () => unawaited(_recover(isAccessLost: isAccessLost)),
        child: Text(isAccessLost ? l10n.chooseFolderAgain : l10n.actionRetry),
      ),
    );
  }

  Future<void> _recover({required bool isAccessLost}) async {
    if (isAccessLost) {
      final uri = await ref.read(sourceFolderPickerProvider).pick();
      if (uri == null || !mounted) return;
      await ref
          .read(appSettingsControllerProvider.notifier)
          .setSourceFolderUri(uri);
      if (!mounted) return;
    }
    ref.invalidate(sourceNotesProvider);
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({
    required this.icon,
    required this.title,
    required this.body,
    required this.action,
  });

  final IconData icon;
  final String title;
  final String body;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = theme.tokens;

    // Scrollabile: con il testo di sistema ingrandito questo contenuto non sta
    // nell'altezza dello schermo.
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(tokens.gapLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: tokens.illustrationSize),
            SizedBox(height: tokens.gap),
            Text(title, style: theme.textTheme.titleLarge),
            SizedBox(height: tokens.gapSmall),
            Text(body, textAlign: TextAlign.center),
            SizedBox(height: tokens.gapLarge),
            action,
          ],
        ),
      ),
    );
  }
}
