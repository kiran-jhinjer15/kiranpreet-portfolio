import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/accent_theme.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/app/theme/theme_controller.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';

class ThemeMenuButton extends StatelessWidget {
  const ThemeMenuButton({super.key});

  static const double _menuWidth = 272;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return MenuAnchor(
      consumeOutsideTap: true,
      clipBehavior: Clip.antiAlias,
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(colors.surfaceElevated),
        surfaceTintColor: WidgetStateProperty.all(colors.surfaceElevated),
        shadowColor: WidgetStateProperty.all(
          colors.textPrimary.withValues(alpha: 0.12),
        ),
        elevation: WidgetStateProperty.all(8),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        alignment: Alignment.bottomLeft,
        maximumSize: WidgetStateProperty.all(const Size(_menuWidth, 520)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            side: BorderSide(color: colors.border),
          ),
        ),
      ),
      builder: (context, controller, child) {
        return IconButton(
          tooltip: 'Theme settings',
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open(
                position: const Offset(
                  AppSpacing.tapTarget - _menuWidth,
                  AppSpacing.tapTarget,
                ),
              );
            }
          },
          icon: const Icon(Icons.palette_outlined),
        );
      },
      menuChildren: const [
        SizedBox(width: _menuWidth, child: ThemeMenuPanel()),
      ],
    );
  }
}

class ThemeMenuPanel extends StatelessWidget {
  const ThemeMenuPanel({super.key});

  static const _appearanceOptions = <(String, ThemeMode)>[
    ('System', ThemeMode.system),
    ('Light', ThemeMode.light),
    ('Dark', ThemeMode.dark),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final controller = ThemeScope.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Appearance',
            style: textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          for (final option in _appearanceOptions)
            _ThemeChoiceRow(
              label: option.$1,
              selected: controller.mode == option.$2,
              onPressed: () => controller.setMode(option.$2),
            ),
          const SizedBox(height: AppSpacing.md),
          Divider(color: colors.border, height: 1),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Accent Color',
            style: textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          for (final theme in AccentThemes.all)
            _ThemeChoiceRow(
              label: theme.name,
              selected: controller.accentTheme.id == theme.id,
              swatch: theme.accent,
              onPressed: () => controller.setAccent(theme),
            ),
        ],
      ),
    );
  }
}

class _ThemeChoiceRow extends StatelessWidget {
  const _ThemeChoiceRow({
    required this.label,
    required this.selected,
    required this.onPressed,
    this.swatch,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;
  final Color? swatch;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        hoverColor: colors.hoverOverlay,
        focusColor: colors.hoverOverlay,
        mouseCursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              if (swatch != null)
                _ColorSwatch(color: swatch!, selected: selected)
              else
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  size: 18,
                  color: selected ? colors.accent : colors.textSecondary,
                ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: textTheme.bodyMedium?.copyWith(
                    color: selected ? colors.textPrimary : colors.textSecondary,
                  ),
                ),
              ),
              if (selected) Icon(Icons.check, size: 16, color: colors.accent),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.color, required this.selected});

  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return AnimatedContainer(
      duration: AppConstants.motionTheme,
      curve: Curves.easeInOut,
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? colors.textPrimary : colors.border,
          width: selected ? 2 : 1,
        ),
      ),
    );
  }
}
