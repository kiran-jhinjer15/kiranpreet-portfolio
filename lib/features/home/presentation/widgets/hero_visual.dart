import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';

class HeroVisual extends StatefulWidget {
  const HeroVisual({super.key});

  @override
  State<HeroVisual> createState() => _HeroVisualState();
}

class _HeroVisualState extends State<HeroVisual> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final compact = !Responsive.isDesktopOrLarger(context);

    return Semantics(
      label: 'Abstract Flutter application composition',
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedScale(
          scale: _hovered && !compact ? 1.015 : 1,
          duration: AppConstants.motionFast,
          curve: Curves.easeOut,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: compact ? 420 : 460),
            child: SizedBox(
              height: compact ? 340 : 400,
              child: const _VisualComposition(),
            ),
          ),
        ),
      ),
    );
  }
}

class _VisualComposition extends StatelessWidget {
  const _VisualComposition();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(top: 36, right: 20, child: _AppPreviewCard()),
        Positioned(top: 0, right: 0, child: _CodeCard()),
        Positioned(left: 0, bottom: 8, child: _StackChip()),
      ],
    );
  }
}

class _AppPreviewCard extends StatelessWidget {
  const _AppPreviewCard();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _Dot(color: colors.border),
                const SizedBox(width: AppSpacing.sm),
                _Dot(color: colors.border),
                const SizedBox(width: AppSpacing.sm),
                _Dot(color: colors.accent),
                const Spacer(),
                Text('Production UI', style: captionStyle),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Mobile workspace', style: titleStyle),
            const SizedBox(height: AppSpacing.xs),
            Text('Android · iOS · Flutter', style: captionStyle),
            const SizedBox(height: AppSpacing.lg),
            const _PreviewRow(),
            const SizedBox(height: AppSpacing.md),
            const _PreviewRow(emphasized: true),
            const SizedBox(height: AppSpacing.md),
            const _PreviewRow(),
            const Spacer(),
            Row(
              children: [
                const Expanded(child: _NavGlyph(active: false)),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(child: _NavGlyph(active: true)),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(child: _NavGlyph(active: false)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({this.emphasized = false});

  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Row(
      children: [
        Container(
          width: AppSpacing.xl,
          height: AppSpacing.xl,
          decoration: BoxDecoration(
            color: emphasized
                ? colors.accent.withValues(alpha: 0.18)
                : colors.border,
            borderRadius: BorderRadius.circular(AppSpacing.xs),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Bar(
                widthFactor: emphasized ? 0.72 : 0.58,
                color: emphasized ? colors.textPrimary : colors.textSecondary,
              ),
              const SizedBox(height: AppSpacing.xs),
              _Bar(widthFactor: emphasized ? 0.46 : 0.38, color: colors.border),
            ],
          ),
        ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.widthFactor, required this.color});

  final double widthFactor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: 6,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }
}

class _CodeCard extends StatelessWidget {
  const _CodeCard();

  static const double _width = 248;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final codeStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      fontFamily: 'monospace',
      height: 1.55,
      color: colors.textSecondary,
    );

    return SizedBox(
      width: _width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.md),
          border: Border.all(color: colors.border),
          boxShadow: [
            BoxShadow(
              color: colors.textPrimary.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: AppSpacing.sm,
                    height: AppSpacing.sm,
                    decoration: BoxDecoration(
                      color: colors.accent,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'main.dart',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text.rich(
                TextSpan(
                  style: codeStyle,
                  children: [
                    TextSpan(
                      text: 'class ',
                      style: codeStyle?.copyWith(color: colors.accent),
                    ),
                    const TextSpan(text: 'Portfolio {\n'),
                    const TextSpan(text: '  build() => App();\n'),
                    const TextSpan(text: '}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StackChip extends StatelessWidget {
  const _StackChip();

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
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Text(
          'Flutter / Dart',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: colors.textPrimary),
        ),
      ),
    );
  }
}

class _NavGlyph extends StatelessWidget {
  const _NavGlyph({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      height: AppSpacing.lg,
      decoration: BoxDecoration(
        color: active ? colors.accent.withValues(alpha: 0.35) : colors.border,
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.sm,
      height: AppSpacing.sm,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}
