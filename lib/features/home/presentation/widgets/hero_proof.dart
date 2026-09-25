import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/home/presentation/hero_copy.dart';

class HeroProof extends StatelessWidget {
  const HeroProof({super.key});

  @override
  Widget build(BuildContext context) {
    final items = HeroProofData.items;
    final compact = Responsive.isMobile(context);

    if (compact) {
      return Wrap(
        spacing: AppSpacing.xxl,
        runSpacing: AppSpacing.lg,
        children: [for (final item in items) _ProofItem(item: item)],
      );
    }

    return Wrap(
      spacing: AppSpacing.xl,
      runSpacing: AppSpacing.lg,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i != 0) const _ProofDivider(),
          _ProofItem(item: items[i]),
        ],
      ],
    );
  }
}

class _ProofItem extends StatelessWidget {
  const _ProofItem({required this.item});

  final HeroProofItem item;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final subtitleStyle = Theme.of(context).textTheme.bodySmall;

    return Semantics(
      label: '${item.title} ${item.subtitle}',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 2,
            height: AppSpacing.xxl,
            margin: const EdgeInsets.only(right: AppSpacing.md),
            color: colors.accent,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: titleStyle),
              const SizedBox(height: AppSpacing.xs),
              Text(item.subtitle, style: subtitleStyle),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProofDivider extends StatelessWidget {
  const _ProofDivider();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return SizedBox(
      height: AppSpacing.xxl,
      child: VerticalDivider(
        width: AppSpacing.xl,
        thickness: 1,
        color: colors.border,
      ),
    );
  }
}
