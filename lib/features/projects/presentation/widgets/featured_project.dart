import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_links.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_status_badge.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_tags.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_visual.dart';

class FeaturedProject extends StatelessWidget {
  const FeaturedProject({
    super.key,
    required this.project,
    required this.visualLeft,
  });

  final ProjectData project;
  final bool visualLeft;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumn =
            Responsive.isDesktopOrLarger(context) ||
            (Responsive.isTablet(context) && constraints.maxWidth >= 840);

        final visual = ProjectVisual(project: project);
        final content = _FeaturedContent(project: project);

        if (!twoColumn) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              content.header,
              const SizedBox(height: AppSpacing.xl),
              visual,
              const SizedBox(height: AppSpacing.xl),
              content.body,
            ],
          );
        }

        final children = visualLeft
            ? [
                Expanded(child: visual),
                const SizedBox(width: AppSpacing.xxxl),
                Expanded(child: content.asColumn),
              ]
            : [
                Expanded(child: content.asColumn),
                const SizedBox(width: AppSpacing.xxxl),
                Expanded(child: visual),
              ];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
      },
    );
  }
}

class _FeaturedContent {
  const _FeaturedContent({required this.project});

  final ProjectData project;

  Widget get header => _FeaturedHeader(project: project);

  Widget get body => _FeaturedBody(project: project);

  Widget get asColumn => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      header,
      const SizedBox(height: AppSpacing.lg),
      body,
    ],
  );
}

class _FeaturedHeader extends StatelessWidget {
  const _FeaturedHeader({required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = !Responsive.isDesktopOrLarger(context);
    final titleStyle = compact
        ? textTheme.headlineMedium
        : textTheme.headlineLarge;
    final status = project.status;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                project.category.toUpperCase(),
                style: textTheme.labelMedium?.copyWith(
                  color: colors.accent,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            if (status != null) ProjectStatusBadge(status: status),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(project.title, style: titleStyle),
        const SizedBox(height: AppSpacing.sm),
        Text(
          _metaLine(project),
          style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }

  String _metaLine(ProjectData project) {
    final parts = <String>[
      if (project.role.isNotEmpty) project.role,
      if (project.platforms.isNotEmpty) project.platforms.join(' / '),
    ];
    return parts.join('  ·  ');
  }
}

class _FeaturedBody extends StatelessWidget {
  const _FeaturedBody({required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.description,
          style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
        ),
        if (project.contributions.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          Text(ProjectsData.contributionHeading, style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          for (final item in project.contributions)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.accent,
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: const SizedBox(width: 10, height: 2),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      item,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
        if (project.ecosystemNote != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            project.ecosystemNote!,
            style: textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
          ),
        ],
        if (project.technologies.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          ProjectTags(technologies: project.technologies),
        ],
        const SizedBox(height: AppSpacing.xl),
        ProjectLinks(project: project),
      ],
    );
  }
}

class FeaturedProjectCard extends StatefulWidget {
  const FeaturedProjectCard({super.key, required this.project});

  final ProjectData project;

  @override
  State<FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<FeaturedProjectCard> {
  bool _hovered = false;

  bool get _hoverEnabled => !Responsive.isMobile(context);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final project = widget.project;

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
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        offset: _hovered ? const Offset(0, -0.01) : Offset.zero,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: colors.projectSurface(project.id.hashCode),
            borderRadius: BorderRadius.circular(AppSpacing.xl),
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
                blurRadius: _hovered ? 22 : 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjectVisual(project: project, height: 168),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.title, style: textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      project.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    if (project.technologies.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      ProjectTags(
                        technologies: project.technologies.take(4).toList(),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.md),
                    ProjectLinks(project: project),
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
