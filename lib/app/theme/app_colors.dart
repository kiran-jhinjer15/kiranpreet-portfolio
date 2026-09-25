import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/accent_theme.dart';
import 'package:kiran_portfolio/app/theme/theme_controller.dart';

abstract final class AppColors {
  static const AppPalette light = AppPalette(
    background: Color(0xFFF7F8FA),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF111318),
    textSecondary: Color(0xFF667085),
    border: Color(0xFFE5E7EB),
    accent: Color(0xFF4F7CFF),
    accentHover: Color(0xFF6B93FF),
    onAccent: Color(0xFFFFFFFF),
    success: Color(0xFF249B6A),
    error: Color(0xFFD64550),
    onError: Color(0xFFFFFFFF),
  );

  static const AppPalette dark = AppPalette(
    background: Color(0xFF0B0D10),
    surface: Color(0xFF12161C),
    surfaceElevated: Color(0xFF181D24),
    textPrimary: Color(0xFFF5F7FA),
    textSecondary: Color(0xFF98A2B3),
    border: Color(0xFF252B34),
    accent: Color(0xFF4F7CFF),
    accentHover: Color(0xFF6B93FF),
    onAccent: Color(0xFFFFFFFF),
    success: Color(0xFF35C98B),
    error: Color(0xFFEF6B73),
    onError: Color(0xFFFFFFFF),
  );

  static AppPalette of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final base = brightness == Brightness.dark ? dark : light;
    final controller = ThemeScope.maybeOf(context);
    if (controller == null) {
      return base;
    }
    return base.withAccent(controller.accentTheme, brightness);
  }
}

final class AppPalette {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.accent,
    required this.accentHover,
    required this.onAccent,
    required this.success,
    required this.error,
    required this.onError,
  });

  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color accent;
  final Color accentHover;
  final Color onAccent;
  final Color success;
  final Color error;
  final Color onError;

  Color get hoverOverlay => accent.withValues(alpha: 0.10);
  Color get pressedOverlay => accent.withValues(alpha: 0.16);
  Color get scrim => textPrimary.withValues(alpha: 0.28);

  AppPalette withAccent(AccentTheme theme, Brightness brightness) {
    return AppPalette(
      background: background,
      surface: surface,
      surfaceElevated: surfaceElevated,
      textPrimary: textPrimary,
      textSecondary: textSecondary,
      border: border,
      accent: theme.resolvedAccent(brightness),
      accentHover: theme.resolvedHover(brightness),
      onAccent: onAccent,
      success: success,
      error: error,
      onError: onError,
    );
  }
}
