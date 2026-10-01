import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/accent_theme.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/app/theme/app_text_styles.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';

abstract final class AppTheme {
  static ThemeData light({AccentTheme accent = AccentThemes.fallback}) {
    return _theme(
      AppColors.light.withAccent(accent, Brightness.light),
      Brightness.light,
    );
  }

  static ThemeData dark({AccentTheme accent = AccentThemes.fallback}) {
    return _theme(
      AppColors.dark.withAccent(accent, Brightness.dark),
      Brightness.dark,
    );
  }

  static ThemeData _theme(AppPalette palette, Brightness brightness) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: palette.accent,
      onPrimary: palette.onAccent,
      primaryContainer: palette.surfaceElevated,
      onPrimaryContainer: palette.textPrimary,
      secondary: palette.rose,
      onSecondary: palette.textPrimary,
      secondaryContainer: palette.warm,
      onSecondaryContainer: palette.textPrimary,
      tertiary: palette.rose,
      onTertiary: palette.textPrimary,
      tertiaryContainer: palette.warm,
      onTertiaryContainer: palette.textPrimary,
      error: palette.error,
      onError: palette.onError,
      surface: palette.surface,
      onSurface: palette.textPrimary,
      onSurfaceVariant: palette.textSecondary,
      outline: palette.border,
      outlineVariant: palette.border,
      shadow: palette.textPrimary,
      scrim: palette.textPrimary,
      inverseSurface: palette.textPrimary,
      onInverseSurface: palette.background,
      inversePrimary: palette.rose,
      surfaceTint: palette.background,
      surfaceContainerLowest: palette.background,
      surfaceContainerLow: palette.surface,
      surfaceContainer: palette.surface,
      surfaceContainerHigh: palette.surfaceElevated,
      surfaceContainerHighest: palette.surfaceElevated,
    );

    final labelLarge = AppTextStyles.labelLarge.copyWith(
      color: palette.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppTextStyles.fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.background,
      canvasColor: palette.background,
      splashColor: palette.pressedOverlay,
      highlightColor: palette.pressedOverlay,
      hoverColor: palette.hoverOverlay,
      focusColor: palette.hoverOverlay,
      dividerColor: palette.border,
      textTheme: AppTextStyles.textTheme(palette),
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: labelLarge,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused)) {
              return palette.accent;
            }
            return palette.textPrimary;
          }),
          overlayColor: WidgetStateProperty.all(palette.hoverOverlay),
          textStyle: WidgetStateProperty.all(AppTextStyles.labelLarge),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.pressed)) {
              return palette.accentHover;
            }
            return palette.accent;
          }),
          foregroundColor: WidgetStateProperty.all(palette.onAccent),
          overlayColor: WidgetStateProperty.all(palette.pressedOverlay),
          elevation: WidgetStateProperty.all(0),
          textStyle: WidgetStateProperty.all(AppTextStyles.labelLarge),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: palette.textPrimary,
          hoverColor: palette.hoverOverlay,
          highlightColor: palette.pressedOverlay,
          minimumSize: const Size(AppSpacing.tapTarget, AppSpacing.tapTarget),
        ),
      ),
      iconTheme: IconThemeData(color: palette.textPrimary),
      dividerTheme: DividerThemeData(
        color: palette.border,
        thickness: 1,
        space: 1,
      ),
      tooltipTheme: const TooltipThemeData(
        waitDuration: Duration(milliseconds: 400),
        preferBelow: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.surface,
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: palette.textSecondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          borderSide: BorderSide(color: palette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          borderSide: BorderSide(color: palette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          borderSide: BorderSide(color: palette.accent),
        ),
      ),
    );
  }
}
