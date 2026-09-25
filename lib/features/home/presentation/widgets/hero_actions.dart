import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/navigation/section_navigator.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/utils/resume_action.dart';
import 'package:kiran_portfolio/core/widgets/portfolio_buttons.dart';
import 'package:kiran_portfolio/features/home/presentation/hero_copy.dart';

class HeroActions extends StatelessWidget {
  const HeroActions({super.key});

  void _onViewWork(BuildContext context) {
    SectionNavigator.maybeOf(context)?.scrollTo(PortfolioSection.projects);
  }

  @override
  Widget build(BuildContext context) {
    final stackButtons = Responsive.isMobile(context);
    final primary = PortfolioPrimaryButton(
      label: HeroCopy.viewWork,
      onPressed: () => _onViewWork(context),
    );
    final secondary = Tooltip(
      message: ResumeAction.isAvailable
          ? ResumeAction.availableLabel
          : ResumeAction.unavailableLabel,
      child: PortfolioSecondaryButton(
        label: HeroCopy.downloadResume,
        onPressed: ResumeAction.isAvailable ? ResumeAction.open : null,
      ),
    );

    if (stackButtons) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          primary,
          const SizedBox(height: AppSpacing.md),
          secondary,
        ],
      );
    }

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [primary, secondary],
    );
  }
}
