import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_image.dart';

/// Full-screen view for one project screenshot, with zoom and pan.
class ProjectImageViewer extends StatelessWidget {
  const ProjectImageViewer({
    super.key,
    required this.assetPath,
    required this.semanticLabel,
  });

  final String assetPath;
  final String semanticLabel;

  static Future<void> show(
    BuildContext context, {
    required String assetPath,
    required String semanticLabel,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.82),
      builder: (context) {
        return ProjectImageViewer(
          assetPath: assetPath,
          semanticLabel: semanticLabel,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final inset = Responsive.isMobile(context) ? AppSpacing.md : AppSpacing.xl;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.all(inset),
      child: Semantics(
        namesRoute: true,
        label: semanticLabel,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.tapTarget),
                    child: InteractiveViewer(
                      minScale: 1,
                      maxScale: 4,
                      child: ProjectImage(
                        assetPath: assetPath,
                        semanticLabel: semanticLabel,
                        fit: BoxFit.contain,
                        labeled: false,
                        decodeForLayout: false,
                        borderRadius: BorderRadius.circular(AppSpacing.sm),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: colors.surfaceElevated,
                      shape: const CircleBorder(),
                      child: IconButton(
                        tooltip: 'Close',
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close, color: colors.textPrimary),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
