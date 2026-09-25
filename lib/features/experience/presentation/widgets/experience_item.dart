import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/experience/data/experience_data.dart';

class ExperienceItemCard extends StatefulWidget {
  const ExperienceItemCard({super.key, required this.item});

  final ExperienceItem item;

  @override
  State<ExperienceItemCard> createState() => _ExperienceItemCardState();
}

class _ExperienceItemCardState extends State<ExperienceItemCard> {
  bool _expanded = false;

  static const int _collapsedCount = 3;

  bool get _canCollapse =>
      Responsive.isMobile(context) &&
      widget.item.responsibilities.length > _collapsedCount;

  List<String> get _visibleResponsibilities {
    if (!_canCollapse || _expanded) {
      return widget.item.responsibilities;
    }
    return widget.item.responsibilities.take(_collapsedCount).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final item = widget.item;
    final compact = !Responsive.isDesktopOrLarger(context);

    return AnimatedContainer(
      duration: AppConstants.motionTheme,
      curve: Curves.easeOut,
      width: double.infinity,
      padding: EdgeInsets.all(compact ? AppSpacing.lg : AppSpacing.xl),
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(
          color: item.isCurrent
              ? colors.accent.withValues(alpha: 0.35)
              : colors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(item.company, style: textTheme.titleMedium)),
              if (item.isCurrent) ...[
                const SizedBox(width: AppSpacing.sm),
                const _CurrentBadge(),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(item.displayRole, style: textTheme.bodyLarge),
          if (item.level != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              item.level!,
              style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          if (!Responsive.isMobile(context))
            Text(
              item.period,
              style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
            ),
          if (!Responsive.isMobile(context))
            const SizedBox(height: AppSpacing.xs),
          Text(
            _locationLine(item),
            style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
          ),
          if (item.projects.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              item.projects.join('  ·  '),
              style: textTheme.labelLarge?.copyWith(color: colors.textPrimary),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          for (final point in _visibleResponsibilities)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
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
                      point,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (_canCollapse)
            TextButton(
              onPressed: () => setState(() => _expanded = !_expanded),
              style: TextButton.styleFrom(
                foregroundColor: colors.accent,
                overlayColor: colors.hoverOverlay,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                minimumSize: const Size(
                  AppSpacing.tapTarget,
                  AppSpacing.tapTarget,
                ),
              ),
              child: Text(
                _expanded
                    ? ExperienceData.showLessLabel
                    : ExperienceData.showMoreLabel,
              ),
            ),
          if (item.technologies.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (var i = 0; i < item.technologies.length; i++)
                  _ExperienceTag(
                    label: item.technologies[i],
                    emphasized: i == 0,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _locationLine(ExperienceItem item) {
    return [
      item.location,
      if (item.workMode != null) item.workMode!,
    ].join('  ·  ');
  }
}

class _CurrentBadge extends StatelessWidget {
  const _CurrentBadge();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppSpacing.xs),
        border: Border.all(color: colors.accent.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          ExperienceData.currentLabel,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: colors.accent,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}

class _ExperienceTag extends StatelessWidget {
  const _ExperienceTag({required this.label, required this.emphasized});

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
