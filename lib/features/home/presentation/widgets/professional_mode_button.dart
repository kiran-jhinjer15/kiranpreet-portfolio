import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/routes/app_routes.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/app/theme/theme_controller.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';

class ProfessionalModeButton extends StatelessWidget {
  const ProfessionalModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final compact = Responsive.isMobile(context);
    final onFreelance =
        AppRouter.delegate.currentConfiguration == AppRoutes.freelance;
    final mode = onFreelance
        ? ProfessionalMode.freelancers
        : ProfessionalMode.companies;
    final label = mode == ProfessionalMode.companies
        ? 'For Companies'
        : 'For Freelancers';

    return MenuAnchor(
      alignmentOffset: const Offset(0, 8),
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(colors.surface),
        surfaceTintColor: WidgetStateProperty.all(colors.surface),
        elevation: WidgetStateProperty.all(8),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.md),
            side: BorderSide(color: colors.border),
          ),
        ),
      ),
      menuChildren: [
        _ModeTile(
          title: 'For Companies',
          subtitle: 'Developer Profile',
          icon: Icons.work_outline,
          selected: mode == ProfessionalMode.companies,
          onSelected: () => _select(context, ProfessionalMode.companies),
        ),
        _ModeTile(
          title: 'For Freelancers',
          subtitle: 'Services & Packages',
          icon: Icons.groups_outlined,
          selected: mode == ProfessionalMode.freelancers,
          onSelected: () => _select(context, ProfessionalMode.freelancers),
        ),
      ],
      builder: (context, controller, child) {
        return Tooltip(
          message: label,
          child: Material(
            color: colors.surface,
            borderRadius: BorderRadius.circular(999),
            child: InkWell(
              onTap: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? AppSpacing.sm : AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      mode == ProfessionalMode.companies
                          ? Icons.work_outline
                          : Icons.groups_outlined,
                      size: 16,
                      color: colors.accent,
                    ),
                    if (!compact) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        label,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: colors.textSecondary,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _select(BuildContext context, ProfessionalMode mode) {
    ThemeScope.maybeOf(context)?.setProfessionalMode(mode);
    AppRouter.go(
      mode == ProfessionalMode.freelancers
          ? AppRoutes.freelance
          : AppRoutes.home,
    );
  }
}

class _ModeTile extends StatelessWidget {
  const _ModeTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onSelected,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return MenuItemButton(
      onPressed: onSelected,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          selected ? colors.background : colors.surface,
        ),
      ),
      child: SizedBox(
        width: 240,
        child: Row(
          children: [
            Icon(icon, size: 18, color: colors.accent),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.labelLarge),
                  Text(
                    selected ? '$subtitle (Current)' : subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (selected) Icon(Icons.check, size: 16, color: colors.accent),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatarButton extends StatelessWidget {
  const ProfileAvatarButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Tooltip(
      message: 'Open profile',
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        label: '${AppConstants.appName}, open profile',
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.surface,
              border: Border.all(color: colors.border),
            ),
            child: Icon(Icons.person_outline, size: 20, color: colors.accent),
          ),
        ),
      ),
    );
  }
}
