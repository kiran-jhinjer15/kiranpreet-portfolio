import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/projects/data/case_study_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/case_study_section.dart';

class TechnicalHighlights extends StatelessWidget {
  const TechnicalHighlights({super.key, required this.highlights});

  final List<CaseStudyHighlight> highlights;

  @override
  Widget build(BuildContext context) {
    if (highlights.isEmpty) {
      return const SizedBox.shrink();
    }

    final columns = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );

    return CaseStudySection(
      title: 'Technical Highlights',
      child: CaseStudyGrid(
        columns: columns,
        itemCount: highlights.length,
        itemBuilder: (index) => _HighlightCard(highlight: highlights[index]),
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({required this.highlight});

  final CaseStudyHighlight highlight;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return CaseStudyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(highlight.icon, size: 20, color: colors.accent),
          const SizedBox(height: AppSpacing.md),
          Text(highlight.title, style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            highlight.detail,
            style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
