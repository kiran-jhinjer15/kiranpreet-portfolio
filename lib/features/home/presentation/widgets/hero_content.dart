import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/home/presentation/hero_copy.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/hero_actions.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = Responsive.isMobile(context);

    final nameStyle =
        (compact ? textTheme.headlineLarge : textTheme.displayLarge)?.copyWith(
          fontWeight: FontWeight.w700,
          height: 1.02,
          letterSpacing: -1,
        );
    final taglineStyle = compact
        ? textTheme.titleLarge
        : textTheme.headlineMedium;
    final descriptionWidth = compact ? double.infinity : 520.0;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            HeroCopy.eyebrow,
            style: textTheme.labelLarge?.copyWith(
              color: colors.accent,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(HeroCopy.name, style: nameStyle),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: compact ? 64 : 88,
            height: 4,
            decoration: BoxDecoration(
              gradient: colors.accentGradient,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
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
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final label in HeroTech.labels) _TechPill(label: label),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          const HeroActions(),
        ],
      ),
    );
  }
}

class _TechPill extends StatefulWidget {
  const _TechPill({required this.label});

  final String label;

  @override
  State<_TechPill> createState() => _TechPillState();
}

class _TechPillState extends State<_TechPill> {
  bool _hovered = false;

  bool get _hoverEnabled => !Responsive.isMobile(context);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

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
      child: AnimatedContainer(
        duration: AppConstants.motionFast,
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: _hovered ? colors.accent : colors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: _hovered ? colors.accent : colors.border),
        ),
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: _hovered ? colors.onAccent : colors.accent,
          ),
        ),
      ),
    );
  }
}
