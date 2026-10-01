import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/routes/app_routes.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/navigation/section_request.dart';
import 'package:kiran_portfolio/core/widgets/app_section.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/editorial_layout.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_footer.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_shell.dart';
import 'package:kiran_portfolio/features/profile/presentation/profile_copy.dart';

/// Route shell for the freelance services page. The services content is added
/// in the next module.
class FreelancePage extends StatelessWidget {
  const FreelancePage({super.key});

  void _openHomeSection(PortfolioSection section) {
    SectionRequest.request(section);
    AppRouter.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Title(
      title: '${ProfileCopy.freelanceTitle} | ${AppConstants.appName}',
      color: AppColors.light.accent,
      child: PortfolioShell(
        onUnavailableSection: _openHomeSection,
        body: EditorialLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSection(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ProfileCopy.freelanceSubtitle,
                        style: textTheme.labelMedium?.copyWith(
                          color: colors.accent,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        ProfileCopy.freelanceTitle,
                        style: textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        ProfileCopy.freelanceDescription,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Services & packages coming soon.',
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const PortfolioFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
