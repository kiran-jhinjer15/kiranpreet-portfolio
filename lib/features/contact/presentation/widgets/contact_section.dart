import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/widgets/entrance_transition.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/utils/resume_action.dart';
import 'package:kiran_portfolio/core/widgets/app_section.dart';
import 'package:kiran_portfolio/core/widgets/portfolio_buttons.dart';
import 'package:kiran_portfolio/core/widgets/section_anchor.dart';
import 'package:kiran_portfolio/features/contact/data/contact_data.dart';
import 'package:kiran_portfolio/features/contact/presentation/widgets/contact_detail_card.dart';
import 'package:kiran_portfolio/features/contact/presentation/widgets/contact_form.dart';
import 'package:kiran_portfolio/features/contact/presentation/widgets/contact_social_button.dart';
import 'package:kiran_portfolio/features/home/presentation/hero_copy.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
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
    final twoColumn = MediaQuery.sizeOf(context).width >= 720;

    return SectionAnchor(
      section: PortfolioSection.contact,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: AppSection(
          child: Semantics(
            container: true,
            header: true,
            label: ContactData.eyebrow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EntranceTransition(
                  animation: _controller,
                  interval: const Interval(0, 0.48, curve: Curves.easeOutCubic),
                  child: const _ContactIntro(),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                EntranceTransition(
                  animation: _controller,
                  interval: const Interval(
                    0.16,
                    0.78,
                    curve: Curves.easeOutCubic,
                  ),
                  child: twoColumn
                      ? const _ContactColumns()
                      : const _ContactStack(),
                ),
                const SizedBox(height: AppSpacing.huge),
                EntranceTransition(
                  animation: _controller,
                  interval: const Interval(0.42, 1, curve: Curves.easeOutCubic),
                  child: const _ContactFooter(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactIntro extends StatelessWidget {
  const _ContactIntro();

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
            ContactData.eyebrow,
            style: textTheme.labelMedium?.copyWith(
              color: colors.accent,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(ContactData.heading, style: headingStyle),
          const SizedBox(height: AppSpacing.lg),
          Text(
            ContactData.description,
            style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _ContactColumns extends StatelessWidget {
  const _ContactColumns();

  @override
  Widget build(BuildContext context) {
    final gap = Responsive.isDesktopOrLarger(context)
        ? AppSpacing.xxl
        : AppSpacing.xl;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: _ContactDetails()),
        SizedBox(width: gap),
        const Expanded(child: ContactForm()),
      ],
    );
  }
}

class _ContactStack extends StatelessWidget {
  const _ContactStack();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ContactDetails(),
        SizedBox(height: AppSpacing.xxl),
        ContactForm(),
      ],
    );
  }
}

class _ContactDetails extends StatelessWidget {
  const _ContactDetails();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          ContactData.introduction,
          style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
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
        const SizedBox(height: AppSpacing.md),
        const ContactDetailCard(
          label: ContactData.locationLabel,
          value: ContactData.locationValue,
          leading: Icon(Icons.location_on_outlined),
        ),
      ],
    );
  }
}

class _ContactFooter extends StatelessWidget {
  const _ContactFooter();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final stacked = Responsive.isMobile(context);
    final prompt = Text(
      ContactData.preferEmail,
      style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
    );
    final emailButton = Tooltip(
      message: ContactData.hasConfiguredEmail
          ? ContactData.emailMe
          : ContactData.emailUnavailableMessage,
      child: PortfolioSecondaryButton(
        label: ContactData.emailMe,
        onPressed: ContactData.hasConfiguredEmail
            ? () => ContactActions.emailMe(context)
            : null,
      ),
    );
    final resumeButton = Tooltip(
      message: ResumeAction.isAvailable
          ? ResumeAction.availableLabel
          : ResumeAction.unavailableLabel,
      child: PortfolioSecondaryButton(
        label: HeroCopy.downloadResume,
        onPressed: ResumeAction.isAvailable ? ResumeAction.open : null,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stacked)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(alignment: Alignment.centerLeft, child: prompt),
              const SizedBox(height: AppSpacing.md),
              emailButton,
              const SizedBox(height: AppSpacing.md),
              resumeButton,
            ],
          )
        else
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [prompt, emailButton, resumeButton],
          ),
        const SizedBox(height: AppSpacing.xl),
        const ContactSocialLinks(),
      ],
    );
  }
}
