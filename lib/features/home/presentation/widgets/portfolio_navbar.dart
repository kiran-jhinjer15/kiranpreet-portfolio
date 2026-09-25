import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/widgets/app_content.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/theme_menu.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/theme_toggle_button.dart';

class PortfolioNavbar extends StatelessWidget {
  const PortfolioNavbar({
    super.key,
    required this.isScrolled,
    required this.isMenuOpen,
    required this.onBrandTap,
    required this.onSectionSelected,
    required this.onMenuToggle,
    this.activeSection,
  });

  final bool isScrolled;
  final bool isMenuOpen;
  final VoidCallback onBrandTap;
  final ValueChanged<PortfolioSection> onSectionSelected;
  final VoidCallback onMenuToggle;
  final PortfolioSection? activeSection;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final showDesktopNav = Responsive.isDesktopOrLarger(context);

    return AnimatedContainer(
      duration: AppConstants.motionFast,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isScrolled ? colors.surface : colors.background,
        border: Border(bottom: BorderSide(color: colors.border)),
      ),
      child: AppContent(
        child: SizedBox(
          height: AppSpacing.navbarHeight,
          child: Semantics(
            container: true,
            label: 'Primary navigation',
            child: Row(
              children: [
                _BrandButton(onPressed: onBrandTap),
                const Spacer(),
                if (showDesktopNav) ...[
                  for (final section in PortfolioSection.values)
                    _NavLink(
                      label: section.label,
                      isActive: activeSection == section,
                      onPressed: () => onSectionSelected(section),
                    ),
                  const SizedBox(width: AppSpacing.sm),
                  const ThemeMenuButton(),
                ] else
                  MenuToggleButton(isOpen: isMenuOpen, onPressed: onMenuToggle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandButton extends StatelessWidget {
  const _BrandButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
      letterSpacing: 1.8,
      color: colors.textPrimary,
    );

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: colors.textPrimary,
        overlayColor: colors.hoverOverlay,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        minimumSize: const Size(AppSpacing.tapTarget, AppSpacing.tapTarget),
      ),
      child: Text(
        AppConstants.brandName,
        semanticsLabel: AppConstants.appName,
        style: textStyle,
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.onPressed,
    required this.isActive,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (isActive ||
              states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return colors.accent;
          }
          return colors.textSecondary;
        }),
        overlayColor: WidgetStateProperty.all(colors.hoverOverlay),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(AppSpacing.tapTarget, AppSpacing.tapTarget),
        ),
        textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.labelLarge,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(height: AppSpacing.xs),
          AnimatedContainer(
            duration: AppConstants.motionTheme,
            curve: Curves.easeInOut,
            height: 2,
            width: isActive ? 16 : 0,
            decoration: BoxDecoration(
              color: isActive
                  ? colors.accent
                  : colors.background.withValues(alpha: 0),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}
