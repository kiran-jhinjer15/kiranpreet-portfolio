import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/features/projects/data/case_study_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/case_study_section.dart';

class ProductFlow extends StatelessWidget {
  const ProductFlow({super.key, required this.steps});

  final List<ProductFlowStep> steps;

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return const SizedBox.shrink();
    }

    return CaseStudySection(
      title: 'Product Flow',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontal = constraints.maxWidth >= 760;
          if (!horizontal) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var index = 0; index < steps.length; index++) ...[
                  if (index != 0) const _FlowArrow(vertical: true),
                  _FlowCard(step: steps[index]),
                ],
              ],
            );
          }

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var index = 0; index < steps.length; index++) ...[
                  if (index != 0) const _FlowArrow(vertical: false),
                  Expanded(child: _FlowCard(step: steps[index])),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FlowArrow extends StatelessWidget {
  const _FlowArrow({required this.vertical});

  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final icon = Icon(
      vertical ? Icons.arrow_downward : Icons.arrow_forward,
      size: 16,
      color: colors.textSecondary,
    );

    if (vertical) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: icon,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Center(child: icon),
    );
  }
}

class _FlowCard extends StatelessWidget {
  const _FlowCard({required this.step});

  final ProductFlowStep step;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return CaseStudyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(step.label, style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            step.detail,
            style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
