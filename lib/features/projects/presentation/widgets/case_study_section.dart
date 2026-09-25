import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';

class CaseStudySection extends StatelessWidget {
  const CaseStudySection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.lg),
        child,
      ],
    );
  }
}

class CaseStudyProse extends StatelessWidget {
  const CaseStudyProse({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: child,
      ),
    );
  }
}

class CaseStudyGrid extends StatelessWidget {
  const CaseStudyGrid({
    super.key,
    required this.columns,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int columns;
  final int itemCount;
  final Widget Function(int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    const gap = AppSpacing.lg;
    final rows = <List<int>>[];
    for (var i = 0; i < itemCount; i += columns) {
      final end = i + columns < itemCount ? i + columns : itemCount;
      rows.add([for (var index = i; index < end; index++) index]);
    }

    return Column(
      children: [
        for (var row = 0; row < rows.length; row++) ...[
          if (row != 0) const SizedBox(height: gap),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var column = 0; column < columns; column++) ...[
                  if (column != 0) const SizedBox(width: gap),
                  Expanded(
                    child: column < rows[row].length
                        ? itemBuilder(rows[row][column])
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class CaseStudyCard extends StatelessWidget {
  const CaseStudyCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: child,
      ),
    );
  }
}
