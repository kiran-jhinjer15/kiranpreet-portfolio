import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';

class PortfolioPrimaryButton extends StatelessWidget {
  const PortfolioPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.focused)) {
            return colors.accentHover;
          }
          return colors.accent;
        }),
        foregroundColor: WidgetStateProperty.all(colors.onAccent),
        overlayColor: WidgetStateProperty.all(colors.pressedOverlay),
        minimumSize: WidgetStateProperty.all(
          const Size(AppSpacing.tapTarget, 48),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
        ),
        textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.labelLarge,
        ),
        animationDuration: AppConstants.motionFast,
      ),
      child: Text(label),
    );
  }
}

class PortfolioSecondaryButton extends StatelessWidget {
  const PortfolioSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colors.textSecondary;
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return colors.accent;
          }
          return colors.textPrimary;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return colors.surface;
          }
          return colors.background.withValues(alpha: 0);
        }),
        overlayColor: WidgetStateProperty.all(colors.hoverOverlay),
        side: WidgetStateProperty.resolveWith((states) {
          final hovered =
              states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused);
          return BorderSide(color: hovered ? colors.accent : colors.border);
        }),
        minimumSize: WidgetStateProperty.all(
          const Size(AppSpacing.tapTarget, 48),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
        ),
        textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.labelLarge,
        ),
        animationDuration: AppConstants.motionFast,
      ),
      child: Text(label),
    );
  }
}
