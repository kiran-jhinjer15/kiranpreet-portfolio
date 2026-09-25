import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/routes/app_routes.dart';
import 'package:kiran_portfolio/core/utils/external_link.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';

class ProjectLinks extends StatelessWidget {
  const ProjectLinks({
    super.key,
    required this.project,
    this.includeCaseStudy = true,
  });

  final ProjectData project;
  final bool includeCaseStudy;

  static bool hasExternalLinks(ProjectData project) {
    return ExternalLink.httpUrl(project.appStoreUrl) != null ||
        ExternalLink.httpUrl(project.playStoreUrl) != null ||
        ExternalLink.httpUrl(project.websiteUrl) != null ||
        ExternalLink.httpUrl(project.githubUrl) != null;
  }

  @override
  Widget build(BuildContext context) {
    final caseStudy = includeCaseStudy ? project.caseStudyRoute : null;
    final appStore = ExternalLink.httpUrl(project.appStoreUrl);
    final playStore = ExternalLink.httpUrl(project.playStoreUrl);
    final website = ExternalLink.httpUrl(project.websiteUrl);
    final github = ExternalLink.httpUrl(project.githubUrl);

    if (caseStudy == null &&
        appStore == null &&
        playStore == null &&
        website == null &&
        github == null) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        if (caseStudy != null)
          ProjectActionButton(
            label: 'View Case Study',
            icon: Icons.arrow_forward,
            emphasized: true,
            onPressed: () => AppRouter.go(caseStudy),
          ),
        if (appStore != null)
          ProjectActionButton(
            label: 'View on App Store',
            onPressed: () => ExternalLink.open(appStore),
          ),
        if (playStore != null)
          ProjectActionButton(
            label: 'Get it on Google Play',
            onPressed: () => ExternalLink.open(playStore),
          ),
        if (website != null)
          ProjectActionButton(
            label: 'Visit Website',
            onPressed: () => ExternalLink.open(website),
          ),
        if (github != null)
          ProjectActionButton(
            label: 'View on GitHub',
            onPressed: () => ExternalLink.open(github),
          ),
      ],
    );
  }
}

class ProjectActionButton extends StatefulWidget {
  const ProjectActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.emphasized = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool emphasized;

  @override
  State<ProjectActionButton> createState() => _ProjectActionButtonState();
}

class _ProjectActionButtonState extends State<ProjectActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: OutlinedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (widget.emphasized ||
                states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused)) {
              return colors.accent;
            }
            return colors.textPrimary;
          }),
          overlayColor: WidgetStateProperty.all(colors.hoverOverlay),
          side: WidgetStateProperty.resolveWith((states) {
            final active =
                widget.emphasized ||
                states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused);
            return BorderSide(color: active ? colors.accent : colors.border);
          }),
          minimumSize: WidgetStateProperty.all(
            const Size(AppSpacing.tapTarget, 44),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            Theme.of(context).textTheme.labelLarge,
          ),
          animationDuration: AppConstants.motionFast,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.label),
            if (widget.icon != null) ...[
              const SizedBox(width: AppSpacing.sm),
              AnimatedSlide(
                offset: _hovered ? const Offset(0.12, 0) : Offset.zero,
                duration: AppConstants.motionTheme,
                curve: Curves.easeOut,
                child: Icon(widget.icon, size: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
