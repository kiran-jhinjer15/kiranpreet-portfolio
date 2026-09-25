import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/routes/app_routes.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/case_study_section.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_links.dart';

class NextProjectCard extends StatelessWidget {
  const NextProjectCard({super.key, required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final next = ProjectsData.nextCaseStudy(project);
    final route = next?.caseStudyRoute;
    if (next == null || route == null) {
      return const SizedBox.shrink();
    }

    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return CaseStudySection(
      title: 'Next Project',
      child: CaseStudyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              next.category.toUpperCase(),
              style: textTheme.labelMedium?.copyWith(
                color: colors.accent,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(next.title, style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              next.description,
              style: textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ProjectActionButton(
              label: 'View Case Study',
              icon: Icons.arrow_forward,
              emphasized: true,
              onPressed: () => AppRouter.go(route),
            ),
          ],
        ),
      ),
    );
  }
}
