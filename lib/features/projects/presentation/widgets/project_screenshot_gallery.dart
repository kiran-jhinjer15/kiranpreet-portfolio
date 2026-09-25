import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_image.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_image_viewer.dart';

/// Case-study gallery. Renders nothing when a project has no screenshots.
class ProjectScreenshotGallery extends StatelessWidget {
  const ProjectScreenshotGallery({super.key, required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final shots = project.screenshots;
    if (shots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final pair = !Responsive.isMobile(context) && width >= 560;
          final desktop =
              Responsive.isDesktopOrLarger(context) &&
              width >= 640 &&
              shots.length > 1;

          if (desktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _tile(context, 0)),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      for (var index = 1; index < shots.length; index++) ...[
                        if (index > 1) const SizedBox(height: AppSpacing.lg),
                        _tile(context, index),
                      ],
                    ],
                  ),
                ),
              ],
            );
          }

          if (pair && shots.length > 1) {
            final tileWidth = (width - AppSpacing.lg) / 2;
            return Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.lg,
              children: [
                for (var index = 0; index < shots.length; index++)
                  SizedBox(width: tileWidth, child: _tile(context, index)),
              ],
            );
          }

          return Column(
            children: [
              for (var index = 0; index < shots.length; index++) ...[
                if (index > 0) const SizedBox(height: AppSpacing.lg),
                _tile(context, index),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _tile(BuildContext context, int index) {
    final path = project.screenshots[index];
    final label = project.screenshotLabel(index);

    return ProjectImage(
      assetPath: path,
      semanticLabel: label,
      onTap: () => ProjectImageViewer.show(
        context,
        assetPath: path,
        semanticLabel: label,
      ),
    );
  }
}
