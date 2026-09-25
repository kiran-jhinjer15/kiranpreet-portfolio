import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/features/experience/data/experience_data.dart';

class ExperienceCareerProgression extends StatelessWidget {
  const ExperienceCareerProgression({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final steps = ExperienceData.progressionSteps;

    return Semantics(
      container: true,
      label: ExperienceData.progressionHeading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ExperienceData.progressionHeading, style: textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.accent,
              borderRadius: BorderRadius.circular(1),
            ),
            child: const SizedBox(width: 32, height: 2),
          ),
          const SizedBox(height: AppSpacing.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              ExperienceData.progressionDescription,
              style: textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < steps.length; i++) ...[
                  _ProgressionStep(
                    label: steps[i],
                    isCurrent: i == steps.length - 1,
                  ),
                  if (i != steps.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm,
                        horizontal: 7,
                      ),
                      child: Icon(
                        Icons.arrow_downward,
                        size: 14,
                        color: colors.border,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressionStep extends StatelessWidget {
  const _ProgressionStep({required this.label, required this.isCurrent});

  final String label;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 16,
          height: 16,
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCurrent ? colors.accent : colors.background,
            border: Border.all(
              color: isCurrent ? colors.accent : colors.border,
              width: 1.5,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: isCurrent ? colors.textPrimary : colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
