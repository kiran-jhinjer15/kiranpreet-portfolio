import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/features/about/presentation/about_copy.dart';

class CareerProgression extends StatelessWidget {
  const CareerProgression({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final steps = CareerProgressionData.steps;

    return Semantics(
      container: true,
      label: AboutCopy.progressionLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AboutCopy.progressionLabel,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colors.textSecondary,
              letterSpacing: 1.4,
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
                      child: SizedBox(
                        width: 1,
                        height: AppSpacing.lg,
                        child: ColoredBox(color: colors.border),
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
