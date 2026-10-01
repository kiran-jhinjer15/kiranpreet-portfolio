import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/theme_menu.dart';

class MobileNavMenu extends StatelessWidget {
  const MobileNavMenu({
    super.key,
    required this.onHomeTap,
    required this.onSectionSelected,
    this.activeSection,
  });

  final VoidCallback onHomeTap;
  final ValueChanged<PortfolioSection> onSectionSelected;
  final PortfolioSection? activeSection;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textStyle = Theme.of(context).textTheme.titleMedium;
    final maxMenuHeight =
        MediaQuery.sizeOf(context).height - AppSpacing.navbarHeight;

    return Material(
      color: colors.surfaceElevated,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colors.border)),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxMenuHeight),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.pageHorizontal(context),
                AppSpacing.sm,
                AppSpacing.pageHorizontal(context),
                AppSpacing.md,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppConstants.maxContentWidth,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _MobileNavLink(
                      label: 'Home',
                      isActive: activeSection == null,
                      style: textStyle,
                      onPressed: onHomeTap,
                    ),
                    for (final section in PortfolioSection.values)
                      _MobileNavLink(
                        key: ValueKey('nav-${section.id}'),
                        label: section.label,
                        isActive: activeSection == section,
                        style: textStyle,
                        onPressed: () => onSectionSelected(section),
                      ),
                    const SizedBox(height: AppSpacing.md),
                    Divider(color: colors.border, height: 1),
                    const ThemeMenuPanel(),
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

class _MobileNavLink extends StatelessWidget {
  const _MobileNavLink({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isActive,
    this.style,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isActive;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final color = colors.accent;

    return Semantics(
      button: true,
      selected: isActive,
      label: label,
      child: InkWell(
        onTap: onPressed,
        hoverColor: colors.hoverOverlay,
        focusColor: colors.hoverOverlay,
        mouseCursor: SystemMouseCursors.click,
        overlayColor: WidgetStateProperty.all(colors.hoverOverlay),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.md,
          ),
          child: SizedBox(
            height: AppSpacing.tapTarget,
            child: Row(
              children: [
                AnimatedContainer(
                  duration: AppConstants.motionTheme,
                  curve: Curves.easeInOut,
                  width: 2,
                  height: 16,
                  decoration: BoxDecoration(
                    color: isActive
                        ? colors.accent
                        : colors.background.withValues(alpha: 0),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(label, style: style?.copyWith(color: color)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
