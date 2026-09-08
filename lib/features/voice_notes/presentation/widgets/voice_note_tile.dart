import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme.dart';
import '../../../../core/formatting/duration_format.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/voice_note.dart';

class VoiceNoteTile extends StatelessWidget {
  const VoiceNoteTile({required this.note, required this.onTap, super.key});

  final VoiceNote note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final duration = note.duration;
    final durationLabel = duration == null
        ? l10n.durationUnknown
        : duration.asClock;
    final timeLabel = _timeLabel(context, l10n);

    return Card(
      child: Semantics(
        button: true,
        label: l10n.voiceNoteSemanticLabel(timeLabel, durationLabel),
        child: ExcludeSemantics(
          child: ListTile(
            onTap: onTap,
            leading: Icon(
              note.isUnplayed ? Icons.graphic_eq : Icons.check_circle_outline,
              color: note.isUnplayed
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            title: Text(timeLabel),
            subtitle: Text(durationLabel),
            trailing: _Trailing(note: note),
          ),
        ),
      ),
    );
  }

  /// L'orario si mostra solo se `receivedAt` e coerente col giorno del nome
  /// file: dopo un ripristino da backup mostrerebbe l'ora del ripristino
  /// dentro un gruppo di settimane prima.
  String _timeLabel(BuildContext context, AppLocalizations l10n) {
    if (!note.hasReliableTime) return l10n.timeUnknown;
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.Hm(locale).format(note.receivedAt);
  }
}

class _Trailing extends StatelessWidget {
  const _Trailing({required this.note});

  final VoiceNote note;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final progress = note.progress;

    if (progress != null && !progress.isPlayed && progress.hasResumePoint) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.history,
            size: theme.textTheme.labelMedium?.fontSize,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: theme.tokens.gapSmall),
          Text(progress.position.asClock, style: theme.textTheme.labelMedium),
        ],
      );
    }

    if (note.isUnplayed) {
      return Chip(
        label: Text(l10n.badgeUnplayed),
        visualDensity: VisualDensity.compact,
      );
    }

    return const SizedBox.shrink();
  }
}
