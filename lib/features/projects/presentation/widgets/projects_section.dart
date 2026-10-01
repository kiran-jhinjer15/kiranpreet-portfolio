import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/widgets/entrance_transition.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/widgets/app_section.dart';
import 'package:kiran_portfolio/core/widgets/section_anchor.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/featured_project.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final GlobalKey _otherProjectsKey = GlobalKey();
  ScrollPosition? _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.motionSection,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _tryReveal();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.isCompleted) {
      return;
    }
    final position = Scrollable.maybeOf(context)?.position;
    if (!identical(position, _position)) {
      _position?.removeListener(_tryReveal);
      _position = position;
      _position?.addListener(_tryReveal);
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_tryReveal);
    _controller.dispose();
    super.dispose();
  }

  void _stopListening() {
    _position?.removeListener(_tryReveal);
    _position = null;
  }

  void _scrollToOtherProjects() {
    final target = _otherProjectsKey.currentContext;
    if (target == null) {
      return;
    }
    Scrollable.ensureVisible(
      target,
      duration: AppConstants.motionSection,
      curve: Curves.easeOutCubic,
      alignment: 0.08,
    );
  }

  void _tryReveal() {
    if (!mounted) {
      return;
    }
    if (_controller.isCompleted) {
      _stopListening();
      return;
    }
    if (_controller.isAnimating) {
      return;
    }
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
      _stopListening();
      return;
    }
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) {
      return;
    }
    final top = box.localToGlobal(Offset.zero).dy;
    final viewHeight = MediaQuery.sizeOf(context).height;
    if (top < viewHeight - AppSpacing.huge) {
      _controller.forward();
      _stopListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return SectionAnchor(
      section: PortfolioSection.projects,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: AppSection(
          child: Semantics(
            container: true,
            header: true,
            label: ProjectsData.eyebrow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EntranceTransition(
                  animation: _controller,
                  interval: const Interval(0, 0.58, curve: Curves.easeOutCubic),
                  child: _ProjectsIntro(onViewAll: _scrollToOtherProjects),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                _FeaturedList(animation: _controller),
                const SizedBox(height: AppSpacing.huge),
                EntranceTransition(
                  animation: _controller,
                  interval: const Interval(
                    0.42,
                    0.82,
                    curve: Curves.easeOutCubic,
                  ),
                  child: _OtherProjects(key: _otherProjectsKey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectsIntro extends StatelessWidget {
  const _ProjectsIntro({required this.onViewAll});

  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = !Responsive.isDesktopOrLarger(context);
    final headingStyle = compact
        ? textTheme.headlineMedium
        : textTheme.headlineLarge;

    final heading = Text(ProjectsData.heading, style: headingStyle);
    final viewAll = TextButton(
      onPressed: onViewAll,
      style: TextButton.styleFrom(foregroundColor: colors.accent),
      child: Text(ProjectsData.viewAll),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ProjectsData.eyebrow,
          style: textTheme.labelMedium?.copyWith(
            color: colors.accent,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (compact)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [heading, viewAll],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: heading),
              viewAll,
            ],
          ),
        const SizedBox(height: AppSpacing.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            ProjectsData.description,
            style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
          ),
        ),
      ],
    );
  }
}

class _FeaturedList extends StatelessWidget {
  const _FeaturedList({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final featured = ProjectsData.featured;

    return LayoutBuilder(
      builder: (context, constraints) {
        return _ProjectGrid(
          projects: featured,
          columns: _columnsForWidth(constraints.maxWidth),
          itemBuilder: (project, index, _) {
            return EntranceTransition(
              animation: animation,
              interval: Interval(
                (0.12 + index * 0.1).clamp(0.0, 0.7),
                (0.58 + index * 0.1).clamp(0.72, 1.0),
                curve: Curves.easeOutCubic,
              ),
              child: FeaturedProjectCard(project: project),
            );
          },
        );
      },
    );
  }
}

int _columnsForWidth(double width) {
  if (width >= 920) {
    return 3;
  }
  if (width >= 560) {
    return 2;
  }
  return 1;
}

class _ProjectGrid extends StatelessWidget {
  const _ProjectGrid({
    required this.projects,
    required this.columns,
    required this.itemBuilder,
  });

  final List<ProjectData> projects;
  final int columns;
  final Widget Function(ProjectData project, int index, int columns)
  itemBuilder;

  @override
  Widget build(BuildContext context) {
    const gap = AppSpacing.lg;
    final rows = <List<ProjectData>>[];

    for (var i = 0; i < projects.length; i += columns) {
      final end = i + columns < projects.length ? i + columns : projects.length;
      rows.add(projects.sublist(i, end));
    }

    return Column(
      children: [
        for (var row = 0; row < rows.length; row++) ...[
          if (row != 0) const SizedBox(height: gap),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var column = 0; column < columns; column++) ...[
                  if (column != 0) const SizedBox(width: gap),
                  Expanded(
                    child: column < rows[row].length
                        ? itemBuilder(
                            rows[row][column],
                            row * columns + column,
                            columns,
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _OtherProjects extends StatelessWidget {
  const _OtherProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final projects = ProjectsData.other;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ProjectsData.otherHeading, style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: colors.accentGradient,
            borderRadius: BorderRadius.circular(1),
          ),
          child: const SizedBox(width: 32, height: 2),
        ),
        const SizedBox(height: AppSpacing.xl),
        LayoutBuilder(
          builder: (context, constraints) {
            return _ProjectGrid(
              projects: projects,
              columns: _columnsForWidth(constraints.maxWidth),
              itemBuilder: (project, index, _) => ProjectCard(project: project),
            );
          },
        ),
      ],
    );
  }
}
