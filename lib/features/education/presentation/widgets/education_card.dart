import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/education/data/education_data.dart';

class EducationCard extends StatefulWidget {
  const EducationCard({super.key, required this.item});

  final EducationItem item;

  @override
  State<EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<EducationCard> {
  bool _hovered = false;

  bool get _hoverEnabled => !Responsive.isMobile(context);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final item = widget.item;
    final statusColor = item.isCurrent ? colors.accent : colors.textSecondary;

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
                  alpha: _hovered ? 0.06 : 0.03,
                ),
                blurRadius: _hovered ? 14 : 8,
                offset: Offset(0, _hovered ? 6 : 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.degree, style: textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(
                item.institution,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                item.dateOrStatus,
                style: textTheme.labelMedium?.copyWith(color: statusColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
