import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../../../../core/errors/hush_exception_message.dart';
import '../../../../core/formatting/duration_format.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/player_controller.dart';

class PlayerSheet extends StatelessWidget {
  const PlayerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).tokens;

    // Scrollabile: con il testo di sistema al 200% i controlli e le etichette
    // non stanno nell'altezza del foglio.
    return SingleChildScrollView(
      padding: EdgeInsets.all(tokens.gapLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _ErrorBanner(),
          const _NotificationsBanner(),
          const _ProgressBar(),
          SizedBox(height: tokens.gap),
          const _Controls(),
          SizedBox(height: tokens.gap),
          const _SpeedSelector(),
        ],
      ),
    );
  }
}

class _ErrorBanner extends ConsumerWidget {
  const _ErrorBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(
      playerControllerProvider.select((state) => state.error),
    );
    if (error == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: theme.tokens.gap),
      child: Text(
        error.localized(AppLocalizations.of(context)),
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.error,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _NotificationsBanner extends ConsumerWidget {
  const _NotificationsBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blocked = ref.watch(
      playerControllerProvider.select((state) => state.notificationsBlocked),
    );
    if (!blocked) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: theme.tokens.gap),
      child: Column(
        children: [
          Text(
            l10n.notificationsBlockedTitle,
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: theme.tokens.gapSmall),
          Text(l10n.notificationsBlockedBody, textAlign: TextAlign.center),
          TextButton(
            onPressed: ref
                .read(playerControllerProvider.notifier)
                .openSystemSettings,
            child: Text(l10n.openSystemSettings),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends ConsumerWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final position = ref.watch(
      playerControllerProvider.select((state) => state.position),
    );
    final duration = ref.watch(
      playerControllerProvider.select((state) => state.duration),
    );

    final maxMs = duration?.inMilliseconds ?? 0;
    final positionMs = position.inMilliseconds.clamp(0, maxMs);

    return Column(
      children: [
        Slider(
          value: positionMs.toDouble(),
          max: maxMs == 0 ? 1 : maxMs.toDouble(),
          label: position.asClock,
          semanticFormatterCallback: (value) => l10n.playerProgressLabel(
            Duration(milliseconds: value.round()).asClock,
          ),
          onChanged: maxMs == 0
              ? null
              : (value) => ref
                    .read(playerControllerProvider.notifier)
                    .seek(Duration(milliseconds: value.round())),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(position.asClock, style: theme.textTheme.labelMedium),
            Text(
              duration == null ? l10n.durationUnknown : duration.asClock,
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ],
    );
  }
}

class _Controls extends ConsumerWidget {
  const _Controls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = Theme.of(context).tokens;
    final controller = ref.read(playerControllerProvider.notifier);
    final isPlaying = ref.watch(
      playerControllerProvider.select((state) => state.isPlaying),
    );
    final isLoading = ref.watch(
      playerControllerProvider.select((state) => state.isLoading),
    );
    final skipSeconds = skipInterval.inSeconds;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => controller.skip(-skipInterval),
          icon: const Icon(Icons.replay_10),
          iconSize: tokens.iconSize,
          tooltip: l10n.playerSkipBack(skipSeconds),
        ),
        SizedBox(width: tokens.gap),
        SizedBox(
          width: tokens.controlSize,
          height: tokens.controlSize,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : FilledButton(
                  onPressed: controller.togglePlay,
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    semanticLabel: isPlaying
                        ? l10n.playerPause
                        : l10n.playerPlay,
                  ),
                ),
        ),
        SizedBox(width: tokens.gap),
        IconButton(
          onPressed: () => controller.skip(skipInterval),
          icon: const Icon(Icons.forward_10),
          iconSize: tokens.iconSize,
          tooltip: l10n.playerSkipForward(skipSeconds),
        ),
      ],
    );
  }
}

class _SpeedSelector extends ConsumerWidget {
  const _SpeedSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = ref.watch(
      playerControllerProvider.select((state) => state.speed),
    );

    final theme = Theme.of(context);

    // `scaleDown` invece di uno scorrimento orizzontale: con il testo di
    // sistema ingrandito i segmenti si rimpiccioliscono, senza sparire dietro
    // un gesto. `tapTargetSize` resta quello di default, cosi l'area toccabile
    // rimane di 48dp anche se il segmento disegnato e piu basso.
    return Semantics(
      label: l10n.playerSpeed,
      container: true,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SegmentedButton<double>(
          style: SegmentedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.symmetric(horizontal: theme.tokens.gapSmall),
            textStyle: theme.textTheme.labelMedium,
          ),
          segments: [
            for (final speed in availableSpeeds)
              ButtonSegment(
                value: speed,
                label: Text(l10n.playerSpeedValue(_label(speed))),
              ),
          ],
          selected: {current},
          showSelectedIcon: false,
          onSelectionChanged: (selection) => unawaited(
            ref
                .read(playerControllerProvider.notifier)
                .setSpeed(selection.first),
          ),
        ),
      ),
    );
  }

  String _label(double speed) =>
      speed == speed.roundToDouble() ? speed.toStringAsFixed(0) : '$speed';
}
