import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/routes/app_routes.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/navigation/section_request.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/widgets/app_section.dart';
import 'package:kiran_portfolio/features/contact/data/contact_data.dart';
import 'package:kiran_portfolio/features/contact/presentation/widgets/contact_detail_card.dart';
import 'package:kiran_portfolio/features/education/data/education_data.dart';
import 'package:kiran_portfolio/features/education/presentation/widgets/education_card.dart';
import 'package:kiran_portfolio/features/experience/data/experience_data.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_footer.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_shell.dart';
import 'package:kiran_portfolio/features/profile/presentation/profile_copy.dart';
import 'package:kiran_portfolio/features/profile/presentation/widgets/work_direction_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _openHomeSection(PortfolioSection section) {
    SectionRequest.request(section);
    AppRouter.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: ProfileCopy.title,
      color: AppColors.light.accent,
      child: PortfolioShell(
        onUnavailableSection: _openHomeSection,
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ProfileHero(),
            _ProfileAbout(),
            _ProfileSnapshot(),
            _ProfileEducation(),
            _ProfileJourney(),
            _ProfileDirections(),
            _ProfileContact(),
            PortfolioFooter(),
          ],
        ),
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = !Responsive.isDesktopOrLarger(context);

    return AppSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ProfileCopy.role.toUpperCase(),
            style: textTheme.labelMedium?.copyWith(
              color: colors.accent,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            ProfileCopy.name,
            style: compact ? textTheme.headlineMedium : textTheme.headlineLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(ProfileCopy.role, style: textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              ProfileCopy.introduction,
              style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              ProfileCopy.supporting,
              style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final fact in ProfileCopy.heroFacts)
                _FactChip(label: fact.label),
            ],
          ),
        ],
      ),
    );
  }
}

class _FactChip extends StatelessWidget {
  const _FactChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(color: colors.border),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}

class _ProfileAbout extends StatelessWidget {
  const _ProfileAbout();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return _Band(
      child: AppSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeading(
              eyebrow: ProfileCopy.aboutEyebrow,
              heading: ProfileCopy.aboutHeading,
            ),
            const SizedBox(height: AppSpacing.xl),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final paragraph in ProfileCopy.aboutParagraphs) ...[
                    Text(
                      paragraph,
                      style: textTheme.bodyLarge?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ],
              ),
            ),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final area in ProfileCopy.aboutFocus)
                  _FactChip(label: area),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileSnapshot extends StatelessWidget {
  const _ProfileSnapshot();

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(
            eyebrow: ProfileCopy.snapshotEyebrow,
            heading: ProfileCopy.snapshotHeading,
          ),
          const SizedBox(height: AppSpacing.xl),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = Responsive.value<int>(
                context,
                mobile: 1,
                tablet: 2,
                desktop: 3,
              );
              const gap = AppSpacing.md;
              final width =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final item in ProfileCopy.snapshot)
                    SizedBox(
                      width: width,
                      child: _SnapshotTile(item: item),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SnapshotTile extends StatelessWidget {
  const _SnapshotTile({required this.item});

  final ProfileFact item;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.label,
              style: textTheme.labelMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(item.value ?? '', style: textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class _ProfileEducation extends StatelessWidget {
  const _ProfileEducation();

  @override
  Widget build(BuildContext context) {
    final sideBySide = Responsive.isDesktopOrLarger(context);

    return _Band(
      child: AppSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeading(
              eyebrow: ProfileCopy.educationEyebrow,
              heading: ProfileCopy.educationHeading,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (sideBySide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < EducationData.items.length; i++) ...[
                    if (i != 0) const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: EducationCard(item: EducationData.items[i]),
                    ),
                  ],
                ],
              )
            else
              Column(
                children: [
                  for (var i = 0; i < EducationData.items.length; i++) ...[
                    if (i != 0) const SizedBox(height: AppSpacing.md),
                    EducationCard(item: EducationData.items[i]),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ProfileJourney extends StatelessWidget {
  const _ProfileJourney();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return AppSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(
            eyebrow: ProfileCopy.journeyEyebrow,
            heading: ProfileCopy.journeyHeading,
          ),
          const SizedBox(height: AppSpacing.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              ProfileCopy.journeyNote,
              style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          for (var i = 0; i < ExperienceData.items.length; i++) ...[
            if (i != 0) const SizedBox(height: AppSpacing.md),
            _JourneyRow(item: ExperienceData.items[i]),
          ],
        ],
      ),
    );
  }
}

class _JourneyRow extends StatelessWidget {
  const _JourneyRow({required this.item});

  final ExperienceItem item;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        border: Border.all(
          color: item.isCurrent
              ? colors.accent.withValues(alpha: 0.4)
              : colors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.displayRole, style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              item.company,
              style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${item.period} · ${item.location}',
              style: textTheme.labelMedium?.copyWith(
                color: item.isCurrent ? colors.accent : colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileDirections extends StatelessWidget {
  const _ProfileDirections();

  @override
  Widget build(BuildContext context) {
    final sideBySide = Responsive.isDesktopOrLarger(context);

    final developer = WorkDirectionCard(
      title: ProfileCopy.developerTitle,
      subtitle: ProfileCopy.developerSubtitle,
      description: ProfileCopy.developerDescription,
      cta: ProfileCopy.developerCta,
      emphasized: true,
      onPressed: () => AppRouter.go(AppRoutes.home),
    );
    final freelance = WorkDirectionCard(
      title: ProfileCopy.freelanceTitle,
      subtitle: ProfileCopy.freelanceSubtitle,
      description: ProfileCopy.freelanceDescription,
      cta: ProfileCopy.freelanceCta,
      onPressed: () => AppRouter.go(AppRoutes.freelance),
    );

    return _Band(
      child: AppSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeading(
              eyebrow: ProfileCopy.directionsEyebrow,
              heading: ProfileCopy.directionsHeading,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (sideBySide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: developer),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(child: freelance),
                ],
              )
            else
              Column(
                children: [
                  developer,
                  const SizedBox(height: AppSpacing.lg),
                  freelance,
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ProfileContact extends StatelessWidget {
  const _ProfileContact();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return AppSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _SectionHeading(
            eyebrow: ProfileCopy.contactEyebrow,
            heading: ProfileCopy.contactHeading,
          ),
          const SizedBox(height: AppSpacing.xl),
          ContactDetailCard(
            label: ContactData.emailLabel,
            value: ContactData.displayEmail,
            leading: const Icon(Icons.mail_outline),
            selectableValue: true,
            trailing: ContactData.hasConfiguredEmail
                ? IconButton(
                    tooltip: ContactData.copyEmailTooltip,
                    onPressed: () => ContactActions.copyEmail(context),
                    icon: const Icon(Icons.copy_outlined, size: 18),
                  )
                : null,
          ),
          const SizedBox(height: AppSpacing.md),
          ContactDetailCard(
            label: ContactData.linkedInLabel,
            value: ContactData.configuredLinkedInUrl == null
                ? ContactData.linkedInUnavailableMessage
                : ContactData.linkedInValue,
            leading: Text(
              'in',
              style: textTheme.labelLarge?.copyWith(color: colors.accent),
            ),
            onPressed: ContactData.configuredLinkedInUrl == null
                ? null
                : () => ContactActions.openLinkedIn(context),
          ),
          const SizedBox(height: AppSpacing.md),
          ContactDetailCard(
            label: ContactData.githubLabel,
            value: ContactData.configuredGithubUrl == null
                ? ContactData.githubUnavailableMessage
                : ContactData.githubValue,
            leading: const Icon(Icons.code),
            onPressed: ContactData.configuredGithubUrl == null
                ? null
                : () => ContactActions.openGitHub(context),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.eyebrow, required this.heading});

  final String eyebrow;
  final String heading;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = !Responsive.isDesktopOrLarger(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: textTheme.labelMedium?.copyWith(
            color: colors.accent,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          heading,
          style: compact ? textTheme.headlineMedium : textTheme.headlineLarge,
        ),
      ],
    );
  }
}

class _Band extends StatelessWidget {
  const _Band({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.of(context).border)),
      ),
      child: child,
    );
  }
}
