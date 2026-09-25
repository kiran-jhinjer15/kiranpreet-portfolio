import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/home/presentation/hero_copy.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/hero_actions.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/hero_proof.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = Responsive.isMobile(context);

    final nameStyle = compact
        ? textTheme.headlineMedium
        : textTheme.headlineLarge;
    final taglineStyle = compact
        ? textTheme.headlineLarge
        : textTheme.displayMedium;
    final descriptionWidth = compact ? double.infinity : 540.0;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            HeroCopy.eyebrow,
            style: textTheme.labelMedium?.copyWith(
              color: colors.accent,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(HeroCopy.name, style: nameStyle),
          const SizedBox(height: AppSpacing.md),
          Text.rich(
            TextSpan(
              style: taglineStyle?.copyWith(color: colors.textPrimary),
              children: [
                const TextSpan(text: HeroCopy.taglineLead),
                TextSpan(
                  text: HeroCopy.taglineEmphasis,
                  style: taglineStyle?.copyWith(color: colors.accent),
                ),
                const TextSpan(text: HeroCopy.taglineTrail),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: descriptionWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  HeroCopy.description,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(HeroCopy.supporting, style: textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          const HeroActions(),
          const SizedBox(height: AppSpacing.xxl),
          const HeroProof(),
        ],
      ),
    );
  }
}
