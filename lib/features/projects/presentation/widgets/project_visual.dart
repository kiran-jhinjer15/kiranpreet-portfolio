import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_image.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_image_viewer.dart';

class ProjectVisual extends StatefulWidget {
  const ProjectVisual({super.key, required this.project, this.height});

  final ProjectData project;
  final double? height;

  @override
  State<ProjectVisual> createState() => _ProjectVisualState();
}

class _ProjectVisualState extends State<ProjectVisual> {
  bool _hovered = false;

  bool get _hoverEnabled => !Responsive.isMobile(context);

  @override
  Widget build(BuildContext context) {
    final compact = !Responsive.isDesktopOrLarger(context);
    final image = widget.project.previewAsset;

    return Semantics(
      label: image == null
          ? 'Decorative project visual for ${widget.project.title}'
          : null,
      child: MouseRegion(
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
        child: AnimatedSlide(
          offset: _hovered ? const Offset(0, -0.012) : Offset.zero,
          duration: AppConstants.motionTheme,
          curve: Curves.easeOut,
          child: SizedBox(
            height: widget.height ?? (compact ? 280 : 360),
            width: double.infinity,
            child: _VisualSurface(
              project: widget.project,
              emphasized: _hovered,
            ),
          ),
        ),
      ),
    );
  }
}

class _VisualSurface extends StatelessWidget {
  const _VisualSurface({required this.project, required this.emphasized});

  final ProjectData project;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final image = project.previewAsset;
    final label = project.screenshotLabel(0);

    return AnimatedContainer(
      duration: AppConstants.motionTheme,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(
          color: emphasized
              ? colors.accent.withValues(alpha: 0.45)
              : colors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(
              alpha: emphasized ? 0.08 : 0.04,
            ),
            blurRadius: emphasized ? 20 : 12,
            offset: Offset(0, emphasized ? 12 : 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: image == null
          ? _FallbackVisual(project: project)
          : ProjectImage(
              assetPath: image,
              semanticLabel: label,
              fit: BoxFit.contain,
              borderRadius: BorderRadius.zero,
              fallback: _FallbackVisual(project: project),
              onTap: () => ProjectImageViewer.show(
                context,
                assetPath: image,
                semanticLabel: label,
              ),
            ),
    );
  }
}

class _FallbackVisual extends StatelessWidget {
  const _FallbackVisual({required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final initials = _initialsFor(project.title);
    final variant = project.id.hashCode.abs() % 3;

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 220;
        return Padding(
          padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.xl),
          child: Stack(
            children: [
              Positioned.fill(child: _AbstractPattern(variant: variant)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROJECT VISUAL',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.textSecondary,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const Spacer(),
                  if (!compact)
                    Text(
                      initials,
                      style: textTheme.displayMedium?.copyWith(
                        color: colors.accent,
                        letterSpacing: -1.2,
                      ),
                    ),
                  if (!compact) const SizedBox(height: AppSpacing.sm),
                  Text(
                    project.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: compact
                        ? textTheme.titleMedium
                        : textTheme.titleLarge,
                  ),
                  if (!compact) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(project.category, style: textTheme.bodySmall),
                    if (project.platforms.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        project.platforms.join('  ·  '),
                        style: textTheme.labelMedium,
                      ),
                    ],
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _initialsFor(String title) {
    final parts = title
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    final word = parts.isEmpty ? title : parts.first;
    if (word.length >= 2) {
      return word.substring(0, 2).toUpperCase();
    }
    return word.toUpperCase();
  }
}

class _AbstractPattern extends StatelessWidget {
  const _AbstractPattern({required this.variant});

  final int variant;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return IgnorePointer(
      child: CustomPaint(
        painter: _PatternPainter(palette: colors, variant: variant),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  const _PatternPainter({required this.palette, required this.variant});

  final AppPalette palette;
  final int variant;

  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint()..color = palette.accent.withValues(alpha: 0.10);
    final stroke = Paint()
      ..color = palette.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    switch (variant) {
      case 1:
        const step = 28.0;
        for (var x = 0.0; x < size.width; x += step) {
          for (var y = 0.0; y < size.height; y += step) {
            canvas.drawCircle(Offset(x + 8, y + 8), 2.2, fill);
          }
        }
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(size.width * 0.42, 24, 88, 88),
            const Radius.circular(12),
          ),
          stroke,
        );
      case 2:
        for (var i = 0; i < 3; i++) {
          final rect = RRect.fromRectAndRadius(
            Rect.fromLTWH(
              size.width * 0.38 + i * 10,
              28.0 + i * 14,
              size.width * 0.46,
              size.height * 0.42,
            ),
            const Radius.circular(10),
          );
          canvas.drawRRect(rect, i == 2 ? fill : stroke);
        }
      default:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              size.width * 0.46,
              18,
              size.width * 0.48,
              size.height * 0.72,
            ),
            const Radius.circular(16),
          ),
          fill,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              size.width * 0.38,
              48,
              size.width * 0.46,
              size.height * 0.58,
            ),
            const Radius.circular(14),
          ),
          stroke,
        );
    }
  }

  @override
  bool shouldRepaint(covariant _PatternPainter oldDelegate) {
    return oldDelegate.variant != variant ||
        oldDelegate.palette.accent != palette.accent ||
        oldDelegate.palette.border != palette.border;
  }
}
