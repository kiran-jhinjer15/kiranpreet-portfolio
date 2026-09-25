import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';

/// Renders one project screenshot from an asset path supplied by project data.
///
/// Phone screenshots use [BoxFit.contain] so interface details stay visible.
/// A missing or invalid file shows [fallback] instead of a broken image icon.
class ProjectImage extends StatelessWidget {
  const ProjectImage({
    super.key,
    required this.assetPath,
    required this.semanticLabel,
    this.fit = BoxFit.contain,
    this.onTap,
    this.fallback,
    this.borderRadius,
    this.labeled = true,
    this.decodeForLayout = true,
  });

  final String assetPath;
  final String semanticLabel;
  final BoxFit fit;
  final VoidCallback? onTap;
  final Widget? fallback;
  final BorderRadius? borderRadius;
  final bool labeled;

  /// When true, decode near the widget's display size.
  /// The zoom viewer sets this false so panning keeps the source detail.
  final bool decodeForLayout;

  static int? _cacheExtent(double? logical, double devicePixelRatio) {
    if (logical == null || !logical.isFinite || logical <= 0) {
      return null;
    }
    final physical = (logical.round() * devicePixelRatio).round();
    if (physical <= 0) {
      return null;
    }
    return physical > 2048 ? 2048 : physical;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final radius = borderRadius ?? BorderRadius.circular(AppSpacing.md);

    final image = MouseRegion(
      cursor: onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: radius,
          child: DecoratedBox(
            decoration: BoxDecoration(color: colors.surfaceElevated),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth.isFinite
                    ? constraints.maxWidth
                    : null;
                final height = constraints.maxHeight.isFinite
                    ? constraints.maxHeight
                    : null;
                final ratio = decodeForLayout
                    ? MediaQuery.devicePixelRatioOf(context)
                    : 1.0;

                return RepaintBoundary(
                  child: Image.asset(
                    assetPath,
                    width: width,
                    height: height,
                    fit: fit,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.high,
                    gaplessPlayback: true,
                    cacheWidth: decodeForLayout
                        ? _cacheExtent(width, ratio)
                        : null,
                    cacheHeight: decodeForLayout
                        ? _cacheExtent(height, ratio)
                        : null,
                    errorBuilder: (context, error, stackTrace) {
                      return fallback ??
                          ProjectImageFallback(label: semanticLabel);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    if (!labeled) {
      return image;
    }

    return Semantics(
      button: onTap != null,
      label: semanticLabel,
      child: ExcludeSemantics(child: image),
    );
  }
}

/// Quiet stand-in used when a screenshot file is missing.
class ProjectImageFallback extends StatelessWidget {
  const ProjectImageFallback({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 160),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceElevated,
          border: Border.all(color: colors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(label, style: textTheme.titleMedium),
          ),
        ),
      ),
    );
  }
}
