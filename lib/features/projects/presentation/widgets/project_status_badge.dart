import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';

class ProjectStatusBadge extends StatelessWidget {
  const ProjectStatusBadge({super.key, required this.status});

  final ProjectStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final highlight = status == ProjectStatus.live
        ? colors.success
        : colors.accent;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: highlight.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppSpacing.xs),
        border: Border.all(color: highlight.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          status.label.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: highlight,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
