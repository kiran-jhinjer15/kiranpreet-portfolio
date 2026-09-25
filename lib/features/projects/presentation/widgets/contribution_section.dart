import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/case_study_section.dart';

class ContributionSection extends StatelessWidget {
  const ContributionSection({super.key, required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final items = project.contributions;
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final columns = Responsive.value<int>(context, mobile: 1, tablet: 2);

    return CaseStudySection(
      title: 'My Contribution',
      child: CaseStudyGrid(
        columns: columns,
        itemCount: items.length,
        itemBuilder: (index) => _ContributionCard(text: items[index]),
      ),
    );
  }
}

class _ContributionCard extends StatelessWidget {
  const _ContributionCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return CaseStudyCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.accent,
                borderRadius: BorderRadius.circular(1),
              ),
              child: const SizedBox(width: 10, height: 2),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
