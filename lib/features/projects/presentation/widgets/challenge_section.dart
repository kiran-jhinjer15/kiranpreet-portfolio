import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/features/projects/data/case_study_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/case_study_section.dart';

class ChallengeSection extends StatelessWidget {
  const ChallengeSection({super.key, required this.challenges});

  final List<CaseStudyChallenge> challenges;

  @override
  Widget build(BuildContext context) {
    if (challenges.isEmpty) {
      return const SizedBox.shrink();
    }

    return CaseStudySection(
      title: 'Challenges & Approach',
      child: Column(
        children: [
          for (var index = 0; index < challenges.length; index++) ...[
            if (index != 0) const SizedBox(height: AppSpacing.lg),
            _ChallengeRow(item: challenges[index]),
          ],
        ],
      ),
    );
  }
}

class _ChallengeRow extends StatelessWidget {
  const _ChallengeRow({required this.item});

  final CaseStudyChallenge item;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sideBySide = constraints.maxWidth >= 720;
        final challenge = _ChallengePane(
          label: 'Challenge',
          text: item.challenge,
        );
        final approach = _ChallengePane(label: 'Approach', text: item.approach);

        if (!sideBySide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              challenge,
              const SizedBox(height: AppSpacing.md),
              approach,
            ],
          );
        }

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: challenge),
              const SizedBox(width: AppSpacing.lg),
              Expanded(child: approach),
            ],
          ),
        );
      },
    );
  }
}

class _ChallengePane extends StatelessWidget {
  const _ChallengePane({required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return CaseStudyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colors.accent,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            text,
            style: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }
}
