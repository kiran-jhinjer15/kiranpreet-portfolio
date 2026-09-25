import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/widgets/entrance_transition.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/widgets/app_content.dart';
import 'package:kiran_portfolio/features/home/presentation/hero_copy.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/hero_content.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/hero_visual.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.motionEntrance,
    );
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight =
        MediaQuery.sizeOf(context).height - AppSpacing.navbarHeight;
    final minHeight = Responsive.value<double>(
      context,
      mobile: 0,
      tablet: availableHeight * 0.72,
      desktop: availableHeight * 0.82,
      largeDesktop: availableHeight * 0.86,
    );
    final verticalPadding = Responsive.value<double>(
      context,
      mobile: AppSpacing.xxl,
      tablet: AppSpacing.xxxl,
      desktop: AppSpacing.huge,
    );

    return Semantics(
      container: true,
      header: true,
      label: '${HeroCopy.name}, Flutter Developer',
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: AppContent(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.pageHorizontal(context),
            vertical: verticalPadding,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final twoColumn =
                  Responsive.isDesktopOrLarger(context) ||
                  (Responsive.isTablet(context) && constraints.maxWidth >= 780);

              if (!twoColumn) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EntranceTransition(
                      animation: _controller,
                      begin: const Offset(0, 0.06),
                      interval: const Interval(
                        0,
                        0.72,
                        curve: Curves.easeOutCubic,
                      ),
                      child: const HeroContent(),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    EntranceTransition(
                      animation: _controller,
                      begin: const Offset(0, 0.04),
                      interval: const Interval(
                        0.22,
                        1,
                        curve: Curves.easeOutCubic,
                      ),
                      child: const Center(child: HeroVisual()),
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: EntranceTransition(
                      animation: _controller,
                      begin: const Offset(0, 0.06),
                      interval: const Interval(
                        0,
                        0.72,
                        curve: Curves.easeOutCubic,
                      ),
                      child: const HeroContent(),
                    ),
                  ),
                  SizedBox(
                    width: Responsive.value<double>(
                      context,
                      mobile: AppSpacing.xl,
                      tablet: AppSpacing.xxl,
                      desktop: AppSpacing.xxxl,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: EntranceTransition(
                      animation: _controller,
                      begin: const Offset(0.05, 0),
                      interval: const Interval(
                        0.18,
                        1,
                        curve: Curves.easeOutCubic,
                      ),
                      child: const HeroVisual(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
