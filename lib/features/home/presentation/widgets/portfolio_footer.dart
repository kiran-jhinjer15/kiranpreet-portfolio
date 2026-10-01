import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/section_navigator.dart';
import 'package:kiran_portfolio/features/contact/data/contact_data.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/widgets/app_content.dart';
import 'package:kiran_portfolio/features/contact/presentation/widgets/contact_social_button.dart';

abstract final class _FooterCopy {
  static const String role = 'Flutter Developer';
  static const String description =
      'Building production-ready mobile and web experiences with Flutter.';
  static const String builtWith = 'Built with Flutter';
  static const String backToTop = 'Back to top';

  static String copyright(int year) {
    return '© $year ${AppConstants.appName}. All rights reserved.';
  }
}

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Semantics(
      container: true,
      label: 'Footer',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.footer,
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: AppContent(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.pageHorizontal(context),
            AppSpacing.xxl,
            AppSpacing.pageHorizontal(context),
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _FooterBrand(),
              const _FooterContacts(),
              const SizedBox(height: AppSpacing.xl),
              const _FooterMeta(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.brandName,
          style: textTheme.labelLarge?.copyWith(letterSpacing: 1.8),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(_FooterCopy.role, style: textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Text(
            _FooterCopy.description,
            style: textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
          ),
        ),
      ],
    );
  }
}

class _FooterContacts extends StatelessWidget {
  const _FooterContacts();

  @override
  Widget build(BuildContext context) {
    final hasEmail = ContactData.hasConfiguredEmail;
    final hasSocial =
        ContactData.configuredLinkedInUrl != null ||
        ContactData.configuredGithubUrl != null;
    if (!hasEmail && !hasSocial) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (hasEmail)
            IconButton(
              tooltip: ContactData.emailMe,
              onPressed: () => ContactActions.emailMe(context),
              icon: const Icon(Icons.mail_outline),
            ),
          const ContactSocialLinks(),
        ],
      ),
    );
  }
}

class _FooterMeta extends StatelessWidget {
  const _FooterMeta();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final metaStyle = textTheme.bodySmall?.copyWith(
      color: colors.textSecondary,
    );
    final copyright = Text(
      _FooterCopy.copyright(DateTime.now().year),
      style: metaStyle,
    );
    final builtWith = Text(_FooterCopy.builtWith, style: metaStyle);
    final backToTop = _BackToTop(expand: Responsive.isMobile(context));

    if (Responsive.isDesktopOrLarger(context)) {
      return Row(
        children: [
          Expanded(child: copyright),
          builtWith,
          const SizedBox(width: AppSpacing.xl),
          backToTop,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        copyright,
        const SizedBox(height: AppSpacing.sm),
        builtWith,
        const SizedBox(height: AppSpacing.lg),
        backToTop,
      ],
    );
  }
}

class _BackToTop extends StatelessWidget {
  const _BackToTop({required this.expand});

  final bool expand;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final button = TextButton.icon(
      onPressed: () {
        SectionNavigator.maybeOf(context)?.scrollToTop();
      },
      icon: const Icon(Icons.arrow_upward, size: 16),
      label: const Text(_FooterCopy.backToTop),
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.focused)) {
            return colors.accent;
          }
          return colors.textSecondary;
        }),
        overlayColor: WidgetStateProperty.all(colors.hoverOverlay),
        minimumSize: WidgetStateProperty.all(
          Size(
            expand ? double.infinity : AppSpacing.tapTarget,
            AppSpacing.tapTarget,
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        alignment: expand ? Alignment.center : null,
        textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.labelLarge,
        ),
        animationDuration: AppConstants.motionFast,
      ),
    );

    return Tooltip(
      message: _FooterCopy.backToTop,
      excludeFromSemantics: true,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}
