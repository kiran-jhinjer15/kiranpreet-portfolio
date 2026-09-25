import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/about/presentation/about_copy.dart';
import 'package:kiran_portfolio/features/about/presentation/widgets/about_focus.dart';

class AboutIntro extends StatelessWidget {
  const AboutIntro({super.key});

  @override
  Widget build(BuildContext context) {
    final twoColumn = Responsive.isDesktopOrLarger(context);

    if (twoColumn) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(flex: 5, child: _HeadingColumn()),
          SizedBox(
            width: Responsive.value<double>(
              context,
              mobile: AppSpacing.xl,
              tablet: AppSpacing.xxl,
              desktop: AppSpacing.xxxl,
            ),
          ),
          const Expanded(flex: 6, child: _CopyColumn()),
        ],
      );
    }

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeadingColumn(),
        SizedBox(height: AppSpacing.xxl),
        _CopyColumn(),
      ],
    );
  }
}

class _HeadingColumn extends StatelessWidget {
  const _HeadingColumn();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = !Responsive.isDesktopOrLarger(context);
    final headingStyle = compact
        ? textTheme.headlineMedium
        : textTheme.headlineLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AboutCopy.eyebrow,
          style: textTheme.labelMedium?.copyWith(
            color: colors.accent,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(AboutCopy.heading, style: headingStyle),
        const SizedBox(height: AppSpacing.xxl),
        const _StackVisual(),
      ],
    );
  }
}

class _CopyColumn extends StatelessWidget {
  const _CopyColumn();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final bodyStyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(color: colors.textSecondary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < AboutCopy.paragraphs.length; i++) ...[
          if (i != 0) const SizedBox(height: AppSpacing.lg),
          Text(AboutCopy.paragraphs[i], style: bodyStyle),
        ],
        const SizedBox(height: AppSpacing.xxl),
        const AboutFocus(),
      ],
    );
  }
}

class _StackVisual extends StatelessWidget {
  const _StackVisual();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final labelStyle = Theme.of(context).textTheme.labelMedium;

    return Semantics(
      label: 'Flutter, Dart, Android and iOS',
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceElevated,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (var i = 0; i < AboutCopy.stack.length; i++)
                  _StackChip(
                    label: AboutCopy.stack[i],
                    emphasized: i == 0,
                    style: labelStyle,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StackChip extends StatelessWidget {
  const _StackChip({
    required this.label,
    required this.emphasized,
    required this.style,
  });

  final String label;
  final bool emphasized;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: emphasized
            ? colors.accent.withValues(alpha: 0.12)
            : colors.background,
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
          style: style?.copyWith(
            color: emphasized ? colors.accent : colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
