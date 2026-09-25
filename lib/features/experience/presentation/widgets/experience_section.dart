import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/widgets/entrance_transition.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/widgets/app_section.dart';
import 'package:kiran_portfolio/core/widgets/section_anchor.dart';
import 'package:kiran_portfolio/features/experience/data/experience_data.dart';
import 'package:kiran_portfolio/features/experience/presentation/widgets/career_progression.dart';
import 'package:kiran_portfolio/features/experience/presentation/widgets/experience_timeline.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
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
    final minHeight =
        MediaQuery.sizeOf(context).height - AppSpacing.navbarHeight;

    return SectionAnchor(
      section: PortfolioSection.experience,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colors.border)),
          ),
          child: AppSection(
            child: Semantics(
              container: true,
              header: true,
              label: ExperienceData.eyebrow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EntranceTransition(
                    animation: _controller,
                    interval: const Interval(
                      0,
                      0.52,
                      curve: Curves.easeOutCubic,
                    ),
                    child: const _ExperienceIntro(),
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                  ExperienceTimeline(animation: _controller),
                  const SizedBox(height: AppSpacing.huge),
                  EntranceTransition(
                    animation: _controller,
                    interval: const Interval(
                      0.48,
                      0.92,
                      curve: Curves.easeOutCubic,
                    ),
                    child: const ExperienceCareerProgression(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExperienceIntro extends StatelessWidget {
  const _ExperienceIntro();

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
            ExperienceData.eyebrow,
            style: textTheme.labelMedium?.copyWith(
              color: colors.accent,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(ExperienceData.heading, style: headingStyle),
          const SizedBox(height: AppSpacing.lg),
          Text(
            ExperienceData.description,
            style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
