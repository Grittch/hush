import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme.dart';
import '../../../core/errors/hush_exception.dart';
import '../../../core/errors/hush_exception_message.dart';
import '../../../core/saf/saf_providers.dart';
import '../../../core/settings/app_settings_controller.dart';
import '../../../l10n/app_localizations.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  bool _picking = false;

  Future<void> _choose() async {
    setState(() => _picking = true);
    try {
      final uri = await ref.read(sourceFolderPickerProvider).pick();
      if (uri == null) return;
      await ref
          .read(appSettingsControllerProvider.notifier)
          .setSourceFolderUri(uri);
    } on HushException catch (error) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.localized(l10n))));
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final tokens = theme.tokens;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(tokens.gapLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(l10n.onboardingTitle, style: theme.textTheme.headlineMedium),
              SizedBox(height: tokens.gap),
              Text(l10n.onboardingBody, style: theme.textTheme.bodyLarge),
              SizedBox(height: tokens.gap),
              Text(
                l10n.onboardingHint,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: _picking ? null : _choose,
                child: Text(l10n.onboardingChooseFolder),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
