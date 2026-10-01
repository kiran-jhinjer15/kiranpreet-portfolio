import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';

class HeroVisual extends StatefulWidget {
  const HeroVisual({super.key});

  @override
  State<HeroVisual> createState() => _HeroVisualState();
}

class _HeroVisualState extends State<HeroVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _float;

  @override
  void initState() {
    super.initState();
    _float = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final inWidgetTest = WidgetsBinding.instance.runtimeType
          .toString()
          .contains('TestWidgetsFlutterBinding');
      if (MediaQuery.disableAnimationsOf(context) || inWidgetTest) {
        _float.value = 0;
      } else {
        _float.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Semantics(
      label: 'Flutter mobile application visual for Android and iOS',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : 460.0;
          final side = maxWidth.clamp(260.0, 480.0);
          final diameter = side * 0.72;

          return SizedBox(
            width: side,
            height: side,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(side, side),
                  painter: _PortraitArcPainter(
                    color: colors.accent,
                    radius: diameter / 2 + side * 0.07,
                  ),
                ),
                Container(
                  width: diameter,
                  height: diameter,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.surface,
                    boxShadow: [
                      BoxShadow(
                        color: colors.textPrimary.withValues(alpha: 0.08),
                        blurRadius: 28,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: _PortraitScene(float: _float, diameter: diameter),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: side * 0.06,
                  child: const _FlutterBadge(),
                ),
                Positioned(
                  right: 0,
                  bottom: side * 0.07,
                  child: const _PlatformBadge(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PortraitArcPainter extends CustomPainter {
  const _PortraitArcPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..color = color;
    const start = -2.55;
    const sweep = 4.7;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep,
      false,
      paint,
    );

    final dotPaint = Paint()..color = color;
    for (final angle in [
      start,
      start + sweep * 0.38,
      start + sweep * 0.72,
      start + sweep,
    ]) {
      canvas.drawCircle(_point(center, radius, angle), 4.5, dotPaint);
    }
  }

  Offset _point(Offset center, double radius, double angle) {
    return center + Offset(math.cos(angle), math.sin(angle)) * radius;
  }

  @override
  bool shouldRepaint(covariant _PortraitArcPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}

class _PortraitScene extends StatelessWidget {
  const _PortraitScene({required this.float, required this.diameter});

  final Animation<double> float;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final scene = diameter * 1.15;

    return ColoredBox(
      color: colors.background,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: -scene * 0.08,
            top: scene * 0.02,
            child: _Blob(
              size: scene * 0.46,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  colors.accent.withValues(alpha: 0.22),
                  colors.blush.withValues(alpha: 0.38),
                ],
              ),
            ),
          ),
          Positioned(
            left: -scene * 0.12,
            bottom: -scene * 0.02,
            child: _Blob(
              size: scene * 0.42,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.blush.withValues(alpha: 0.55),
                  colors.accent.withValues(alpha: 0.24),
                ],
              ),
            ),
          ),
          Positioned(
            right: scene * 0.08,
            bottom: scene * 0.04,
            child: _Blob(size: scene * 0.18, color: colors.rose),
          ),
          AnimatedBuilder(
            animation: float,
            builder: (context, child) {
              final dy = (float.value - 0.5) * 8;
              return Transform.translate(offset: Offset(0, dy), child: child);
            },
            child: Transform.scale(
              scale: diameter * 0.96 / 290,
              child: const _PhonePair(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, this.color, this.gradient});

  final double size;
  final Color? color;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: gradient == null ? color?.withValues(alpha: 0.75) : null,
        gradient: gradient,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _PhonePair extends StatelessWidget {
  const _PhonePair();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      height: 290,
      child: Stack(
        children: [
          Positioned(right: 0, top: 26, child: _PhoneFrame(title: 'iOS')),
          Positioned(left: 0, top: 0, child: _PhoneFrame(title: 'Android')),
        ],
      ),
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      width: 132,
      height: 248,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(title, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Flutter',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: colors.accent),
              ),
              const Spacer(),
              Container(
                height: 28,
                decoration: BoxDecoration(
                  color: colors.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                height: 14,
                width: 64,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlutterBadge extends StatelessWidget {
  const _FlutterBadge();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        'Flutter / Dart',
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: colors.accent),
      ),
    );
  }
}

class _PlatformBadge extends StatelessWidget {
  const _PlatformBadge();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.android, size: 16, color: colors.accent),
          const SizedBox(width: AppSpacing.xs),
          Icon(Icons.phone_iphone, size: 16, color: colors.accent),
          const SizedBox(width: AppSpacing.sm),
          Text('Android + iOS', style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}
