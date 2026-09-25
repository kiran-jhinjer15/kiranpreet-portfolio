import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_image.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_image_viewer.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_links.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_status_badge.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_tags.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});

  final ProjectData project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  bool get _hoverEnabled => !Responsive.isMobile(context);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final project = widget.project;
    final status = project.status;

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
      child: AnimatedSlide(
        offset: _hovered ? const Offset(0, -0.012) : Offset.zero,
        duration: AppConstants.motionTheme,
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: AppConstants.motionTheme,
          curve: Curves.easeOut,
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: colors.surfaceElevated,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            border: Border.all(
              color: _hovered
                  ? colors.accent.withValues(alpha: 0.45)
                  : colors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.textPrimary.withValues(
                  alpha: _hovered ? 0.08 : 0.04,
                ),
                blurRadius: _hovered ? 16 : 8,
                offset: Offset(0, _hovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (project.hasScreenshots) ...[
                SizedBox(
                  height: Responsive.value<double>(
                    context,
                    mobile: 220,
                    tablet: 200,
                    desktop: 180,
                  ),
                  width: double.infinity,
                  child: ProjectImage(
                    assetPath: project.screenshots.first,
                    semanticLabel: project.screenshotLabel(0),
                    fit: BoxFit.contain,
                    onTap: () => ProjectImageViewer.show(
                      context,
                      assetPath: project.screenshots.first,
                      semanticLabel: project.screenshotLabel(0),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      project.category.toUpperCase(),
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.accent,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  if (status != null) ProjectStatusBadge(status: status),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(project.title, style: textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(
                project.description,
                style: textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              if (project.technologies.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                ProjectTags(technologies: project.technologies),
              ],
              if (project.hasPublicLinks) ...[
                const SizedBox(height: AppSpacing.lg),
                ProjectLinks(project: project),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
