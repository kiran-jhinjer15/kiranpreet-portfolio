import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';

class ProjectTags extends StatelessWidget {
  const ProjectTags({super.key, required this.technologies});

  final List<String> technologies;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (var i = 0; i < technologies.length; i++)
          _ProjectTag(label: technologies[i], emphasized: i == 0),
      ],
    );
  }
}

class _ProjectTag extends StatelessWidget {
  const _ProjectTag({required this.label, required this.emphasized});

  final String label;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppSpacing.xs),
        border: Border.all(
          color: emphasized
              ? colors.accent.withValues(alpha: 0.35)
              : colors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: emphasized ? colors.accent : colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
