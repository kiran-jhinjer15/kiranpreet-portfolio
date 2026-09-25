import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/widgets/entrance_transition.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/experience/data/experience_data.dart';
import 'package:kiran_portfolio/features/experience/presentation/widgets/experience_item.dart';

class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key, required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final items = ExperienceData.items;
    final compact = Responsive.isMobile(context);

    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i != 0) SizedBox(height: compact ? AppSpacing.xl : AppSpacing.md),
          EntranceTransition(
            animation: animation,
            interval: Interval(
              (0.12 + i * 0.10).clamp(0.0, 0.72),
              (0.52 + i * 0.10).clamp(0.7, 1.0),
              curve: Curves.easeOutCubic,
            ),
            child: _TimelineEntry(
              item: items[i],
              isFirst: i == 0,
              isLast: i == items.length - 1,
              compact: compact,
            ),
          ),
        ],
      ],
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.item,
    required this.isFirst,
    required this.isLast,
    required this.compact,
  });

  final ExperienceItem item;
  final bool isFirst;
  final bool isLast;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final card = ExperienceItemCard(item: item);
    final rail = _TimelineRail(
      isFirst: isFirst,
      isLast: isLast,
      isCurrent: item.isCurrent,
    );

    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.period,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.of(context).textSecondary,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                rail,
                const SizedBox(width: AppSpacing.md),
                Expanded(child: card),
              ],
            ),
          ),
        ],
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Responsive.isDesktopOrLarger(context) ? 120 : 96,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                item.periodShort,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.of(context).textSecondary,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          rail,
          const SizedBox(width: AppSpacing.xl),
          Expanded(child: card),
        ],
      ),
    );
  }
}

class _TimelineRail extends StatelessWidget {
  const _TimelineRail({
    required this.isFirst,
    required this.isLast,
    required this.isCurrent,
  });

  final bool isFirst;
  final bool isLast;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final line = ColoredBox(color: colors.border);

    return SizedBox(
      width: 16,
      child: Column(
        children: [
          SizedBox(
            width: 1,
            height: isFirst ? 8 : AppSpacing.md,
            child: isFirst ? null : line,
          ),
          Container(
            width: isCurrent ? 12 : 10,
            height: isCurrent ? 12 : 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCurrent ? colors.accent : colors.background,
              border: Border.all(
                color: isCurrent ? colors.accent : colors.border,
                width: 1.5,
              ),
            ),
          ),
          if (!isLast)
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 1,
                  height: double.infinity,
                  child: ColoredBox(color: colors.border),
                ),
              ),
            )
          else
            const SizedBox(height: 8),
        ],
      ),
    );
  }
}
