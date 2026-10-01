import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/home/presentation/hero_copy.dart';

class HeroProof extends StatelessWidget {
  const HeroProof({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final items = HeroProofData.items;
    final compact = Responsive.isMobile(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.xl),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        child: compact
            ? Column(
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    if (i != 0) const SizedBox(height: AppSpacing.md),
                    _ProofItem(item: items[i]),
                  ],
                ],
              )
            : Row(
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    if (i != 0) const _ProofDivider(),
                    Expanded(child: _ProofItem(item: items[i])),
                  ],
                ],
              ),
      ),
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
        children: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.background,
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, size: 18, color: colors.accent),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: titleStyle,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: subtitleStyle,
                ),
              ],
            ),
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
