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
                  child: const _ProjectsIntro(),
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
                  child: const _OtherProjects(),
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
  const _ProjectsIntro();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = !Responsive.isDesktopOrLarger(context);
    final headingStyle = compact
        ? textTheme.headlineMedium
        : textTheme.headlineLarge;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: Column(
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
          Text(ProjectsData.heading, style: headingStyle),
          const SizedBox(height: AppSpacing.lg),
          Text(
            ProjectsData.description,
            style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _FeaturedList extends StatelessWidget {
  const _FeaturedList({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final featured = ProjectsData.featured;

    return Column(
      children: [
        for (var i = 0; i < featured.length; i++) ...[
          if (i != 0) const SizedBox(height: AppSpacing.huge),
          EntranceTransition(
            animation: animation,
            interval: Interval(
              (0.12 + i * 0.14).clamp(0.0, 0.7),
              (0.58 + i * 0.14).clamp(0.72, 1.0),
              curve: Curves.easeOutCubic,
            ),
            child: FeaturedProject(project: featured[i], visualLeft: i.isOdd),
          ),
        ],
      ],
    );
  }
}

class _OtherProjects extends StatelessWidget {
  const _OtherProjects();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final columns = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
    final projects = ProjectsData.other;
    const gap = AppSpacing.lg;
    final rows = <List<ProjectData>>[];

    for (var i = 0; i < projects.length; i += columns) {
      final end = i + columns < projects.length ? i + columns : projects.length;
      rows.add(projects.sublist(i, end));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(ProjectsData.otherHeading, style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.accent,
            borderRadius: BorderRadius.circular(1),
          ),
          child: const SizedBox(width: 32, height: 2),
        ),
        const SizedBox(height: AppSpacing.xl),
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
                        ? ProjectCard(project: rows[row][column])
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
