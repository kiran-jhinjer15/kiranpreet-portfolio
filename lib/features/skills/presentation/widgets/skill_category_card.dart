import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/skills/presentation/data/skills_data.dart';
import 'package:kiran_portfolio/features/skills/presentation/widgets/skill_chip.dart';

class SkillCategoryCard extends StatefulWidget {
  const SkillCategoryCard({super.key, required this.category});

  final SkillCategory category;

  @override
  State<SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<SkillCategoryCard> {
  bool _hovered = false;

  bool get _hoverEnabled => !Responsive.isMobile(context);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final category = widget.category;

    return MouseRegion(
      onEnter: (_) {
        if (_hoverEnabled) {
          setState(() => _hovered = true);
        }
      },
      onExit: (_) {
        if (_hovered) {
          setState(() => _hovered = false);
        }
      },
      child: AnimatedSlide(
        offset: _hovered ? const Offset(0, -0.012) : Offset.zero,
        duration: AppConstants.motionTheme,
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: AppConstants.motionTheme,
          curve: Curves.easeOut,
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: colors.surfaceElevated,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            border: Border.all(
              color: _hovered
                  ? colors.accent.withValues(alpha: 0.45)
                  : colors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.textPrimary.withValues(
                  alpha: _hovered ? 0.08 : 0.04,
                ),
                blurRadius: _hovered ? 16 : 8,
                offset: Offset(0, _hovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ExcludeSemantics(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppSpacing.xs),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Icon(
                          category.icon,
                          size: 18,
                          color: colors.accent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(category.title, style: textTheme.titleMedium),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(category.description, style: textTheme.bodySmall),
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final skill in category.skills) SkillChip(label: skill),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
