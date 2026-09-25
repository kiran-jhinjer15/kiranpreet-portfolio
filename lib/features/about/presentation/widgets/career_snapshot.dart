import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/about/presentation/about_copy.dart';

class CareerSnapshot extends StatelessWidget {
  const CareerSnapshot({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final items = CareerSnapshotData.items;
    final columns = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 4,
    );

    return Semantics(
      container: true,
      label: AboutCopy.snapshotLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AboutCopy.snapshotLabel,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colors.textSecondary,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colors.border)),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final gap = AppSpacing.xl;
                final itemWidth = columns == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - gap * (columns - 1)) / columns;

                return Wrap(
                  spacing: gap,
                  runSpacing: AppSpacing.xl,
                  children: [
                    for (final item in items)
                      SizedBox(
                        width: itemWidth,
                        child: _SnapshotItem(item: item),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SnapshotItem extends StatelessWidget {
  const _SnapshotItem({required this.item});

  final CareerSnapshotItem item;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 2,
            height: AppSpacing.xxl,
            margin: const EdgeInsets.only(right: AppSpacing.md, top: 2),
            color: colors.accent,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(item.subtitle, style: textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
