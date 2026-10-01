import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/widgets/app_content.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/professional_mode_button.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/theme_menu.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/theme_toggle_button.dart';

class PortfolioNavbar extends StatelessWidget {
  const PortfolioNavbar({
    super.key,
    required this.isScrolled,
    required this.isMenuOpen,
    required this.onBrandTap,
    required this.onMenuToggle,
  });

  final bool isScrolled;
  final bool isMenuOpen;
  final VoidCallback onBrandTap;
  final VoidCallback onMenuToggle;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final showCompactMenu = Responsive.isMobile(context);

    return AnimatedContainer(
      duration: AppConstants.motionFast,
      curve: Curves.easeOut,
      color: isScrolled
          ? colors.surface.withValues(alpha: 0.94)
          : colors.background,
      child: AppContent(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.pageHorizontal(context),
          AppSpacing.sm,
          AppSpacing.pageHorizontal(context),
          AppSpacing.sm,
        ),
        child: SizedBox(
          height: AppSpacing.navbarHeight - AppSpacing.lg,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.xl),
              border: Border.all(color: colors.border),
              boxShadow: [
                BoxShadow(
                  color: colors.textPrimary.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Semantics(
                container: true,
                label: 'Primary navigation',
                child: Row(
                  children: [
                    Flexible(child: _BrandButton(onPressed: onBrandTap)),
                    const Spacer(),
                    const ProfessionalModeButton(),
                    const SizedBox(width: AppSpacing.sm),
                    if (!showCompactMenu) ...[
                      const ThemeMenuButton(),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    ProfileAvatarButton(onPressed: onBrandTap),
                    if (showCompactMenu)
                      MenuToggleButton(
                        isOpen: isMenuOpen,
                        onPressed: onMenuToggle,
                      ),
                  ],
                ),
              ),
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

    return Tooltip(
      message: 'Open profile',
      excludeFromSemantics: true,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: colors.textPrimary,
          overlayColor: colors.hoverOverlay,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          minimumSize: const Size(0, AppSpacing.tapTarget),
        ),
        child: Text(
          AppConstants.brandName,
          overflow: TextOverflow.ellipsis,
          semanticsLabel: '${AppConstants.appName}, open profile',
          style: textStyle,
        ),
      ),
    );
  }
}
