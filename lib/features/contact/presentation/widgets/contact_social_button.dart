import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/features/contact/data/contact_data.dart';

class ContactSocialLinks extends StatelessWidget {
  const ContactSocialLinks({
    super.key,
    this.alignment = MainAxisAlignment.start,
  });

  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final linkedIn = ContactData.configuredLinkedInUrl;
    final github = ContactData.configuredGithubUrl;
    if (linkedIn == null && github == null) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: alignment,
      children: [
        if (linkedIn != null)
          ContactSocialButton(
            tooltip: ContactData.openLinkedInLabel,
            onPressed: () => ContactActions.openLinkedIn(context),
            icon: Text(
              'in',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: colors.accent),
            ),
          ),
        if (linkedIn != null && github != null)
          const SizedBox(width: AppSpacing.sm),
        if (github != null)
          ContactSocialButton(
            tooltip: ContactData.openGitHubLabel,
            onPressed: () => ContactActions.openGitHub(context),
            icon: const Icon(Icons.code),
          ),
      ],
    );
  }
}

class ContactSocialButton extends StatefulWidget {
  const ContactSocialButton({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  State<ContactSocialButton> createState() => _ContactSocialButtonState();
}

class _ContactSocialButtonState extends State<ContactSocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final active = _hovered;

    return Tooltip(
      message: widget.tooltip,
      excludeFromSemantics: true,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: Semantics(
          button: true,
          label: widget.tooltip,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            hoverColor: colors.hoverOverlay,
            focusColor: colors.hoverOverlay,
            child: AnimatedContainer(
              duration: AppConstants.motionTheme,
              curve: Curves.easeOut,
              width: AppSpacing.tapTarget,
              height: AppSpacing.tapTarget,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? colors.surface : colors.surfaceElevated,
                borderRadius: BorderRadius.circular(AppSpacing.sm),
                border: Border.all(
                  color: active
                      ? colors.accent.withValues(alpha: 0.45)
                      : colors.border,
                ),
              ),
              child: ExcludeSemantics(
                child: IconTheme(
                  data: IconThemeData(
                    size: 18,
                    color: active ? colors.accent : colors.textPrimary,
                  ),
                  child: DefaultTextStyle(
                    style:
                        Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: active ? colors.accent : colors.textPrimary,
                        ) ??
                        const TextStyle(),
                    child: widget.icon,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
