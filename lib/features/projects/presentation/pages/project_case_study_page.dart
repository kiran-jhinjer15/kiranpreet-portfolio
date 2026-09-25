import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/navigation/section_request.dart';
import 'package:kiran_portfolio/core/widgets/app_section.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_shell.dart';
import 'package:kiran_portfolio/features/projects/data/case_study_data.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/case_study_hero.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/case_study_meta.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/case_study_section.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/challenge_section.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/contribution_section.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/next_project_card.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/product_flow.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_links.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_screenshot_gallery.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/technical_highlights.dart';

class ProjectCaseStudyPage extends StatelessWidget {
  const ProjectCaseStudyPage({
    super.key,
    required this.project,
    required this.onBack,
  });

  final ProjectData project;
  final VoidCallback onBack;

  void _openSection(PortfolioSection section) {
    SectionRequest.request(section);
    onBack();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: AppConstants.caseStudyTitle(project.title),
      color: AppColors.light.accent,
      child: PortfolioShell(
        onUnavailableSection: _openSection,
        body: _CaseStudyBody(project: project, onBackToProjects: _openSection),
      ),
    );
  }
}

class _CaseStudyBody extends StatefulWidget {
  const _CaseStudyBody({required this.project, required this.onBackToProjects});

  final ProjectData project;
  final void Function(PortfolioSection section) onBackToProjects;

  @override
  State<_CaseStudyBody> createState() => _CaseStudyBodyState();
}

class _CaseStudyBodyState extends State<_CaseStudyBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _curved;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.motionSection,
    );
    _curved = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(_curved);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = 1;
      } else {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _curved.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final project = widget.project;
    final content = CaseStudyData.forProject(project);

    return FadeTransition(
      opacity: _curved,
      child: SlideTransition(
        position: _slide,
        child: AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () =>
                    widget.onBackToProjects(PortfolioSection.projects),
                style: TextButton.styleFrom(
                  foregroundColor: colors.textSecondary,
                  overlayColor: colors.hoverOverlay,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(
                    AppSpacing.tapTarget,
                    AppSpacing.tapTarget,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                icon: const Icon(Icons.arrow_back, size: 16),
                label: Text(
                  'Back to Projects',
                  style: textTheme.labelLarge?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              CaseStudyHero(project: project),
              const SizedBox(height: AppSpacing.xxl),
              CaseStudyMeta(project: project),
              _gap,
              CaseStudySection(
                title: 'Project Overview',
                child: CaseStudyProse(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.description,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      if (project.ecosystemNote != null) ...[
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          project.ecosystemNote!,
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              _gap,
              ContributionSection(project: project),
              if (content != null) ...[
                _gap,
                ProductFlow(steps: content.flow),
                _gap,
                TechnicalHighlights(highlights: content.highlights),
                _gap,
                ChallengeSection(challenges: content.challenges),
              ],
              _gap,
              _Screens(project: project),
              _PublicLinks(project: project),
              _gap,
              NextProjectCard(project: project),
            ],
          ),
        ),
      ),
    );
  }
}

const _gap = SizedBox(height: AppSpacing.xxxl);

class _Screens extends StatelessWidget {
  const _Screens({required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    final hasScreens = project.hasScreenshots;
    if (!hasScreens && !kDebugMode) {
      return const SizedBox.shrink();
    }

    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return CaseStudySection(
      title: 'Selected Screens',
      child: hasScreens
          ? ProjectScreenshotGallery(project: project)
          : Text(
              'Screenshots will appear here once image files are added to this project.',
              style: textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
    );
  }
}

class _PublicLinks extends StatelessWidget {
  const _PublicLinks({required this.project});

  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    if (!ProjectLinks.hasExternalLinks(project)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxxl),
      child: CaseStudySection(
        title: 'Project Links',
        child: ProjectLinks(project: project, includeCaseStudy: false),
      ),
    );
  }
}
