import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_visual.dart';

class CaseStudyHero extends StatelessWidget {
  const CaseStudyHero({super.key, required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumn = constraints.maxWidth >= 840;
        final copy = _HeroCopy(project: project);
        final visual = ProjectVisual(project: project);

        if (!twoColumn) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              copy,
              const SizedBox(height: AppSpacing.xl),
              visual,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 6, child: copy),
            const SizedBox(width: AppSpacing.xxxl),
            Expanded(flex: 5, child: visual),
          ],
        );
      },
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = !Responsive.isDesktopOrLarger(context);
    final titleStyle = compact
        ? textTheme.headlineMedium
        : textTheme.headlineLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.category.toUpperCase(),
          style: textTheme.labelMedium?.copyWith(
            color: colors.accent,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(project.title, style: titleStyle),
        const SizedBox(height: AppSpacing.lg),
        Text(
          project.description,
          style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
        ),
        if (project.role.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(project.role, style: textTheme.titleMedium),
        ],
      ],
    );
  }
}
