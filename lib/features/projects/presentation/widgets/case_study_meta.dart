import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';

class CaseStudyMeta extends StatelessWidget {
  const CaseStudyMeta({super.key, required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final items = <(String, String)>[
      if (project.role.isNotEmpty) ('Role', project.role),
      if (project.platforms.isNotEmpty)
        ('Platforms', project.platforms.join(' / ')),
      if (project.technologies.isNotEmpty)
        ('Technologies', project.technologies.join(' / ')),
    ];

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: AppSpacing.xxl,
      runSpacing: AppSpacing.lg,
      children: [
        for (final item in items) _MetaItem(label: item.$1, value: item.$2),
      ],
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }
}
