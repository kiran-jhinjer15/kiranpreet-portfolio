import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/widgets/entrance_transition.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/widgets/app_section.dart';
import 'package:kiran_portfolio/core/widgets/section_anchor.dart';
import 'package:kiran_portfolio/features/about/presentation/about_copy.dart';
import 'package:kiran_portfolio/features/about/presentation/widgets/about_intro.dart';
import 'package:kiran_portfolio/features/about/presentation/widgets/career_progression.dart';
import 'package:kiran_portfolio/features/about/presentation/widgets/career_snapshot.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
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
      section: PortfolioSection.about,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: AppSection(
          child: Semantics(
            container: true,
            label: AboutCopy.eyebrow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EntranceTransition(
                  animation: _controller,
                  interval: const Interval(0, 0.72, curve: Curves.easeOutCubic),
                  child: const AboutIntro(),
                ),
                const SizedBox(height: AppSpacing.huge),
                EntranceTransition(
                  animation: _controller,
                  interval: const Interval(
                    0.18,
                    0.88,
                    curve: Curves.easeOutCubic,
                  ),
                  child: const CareerSnapshot(),
                ),
                const SizedBox(height: AppSpacing.huge),
                EntranceTransition(
                  animation: _controller,
                  interval: const Interval(0.32, 1, curve: Curves.easeOutCubic),
                  child: const CareerProgression(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
