import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/accent_theme.dart';
import 'package:kiran_portfolio/app/theme/theme_controller.dart';

abstract final class AppColors {
  static const AppPalette light = AppPalette(
    background: Color(0xFFFAF9F6),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF101A35),
    textSecondary: Color(0xFF64708A),
    border: Color(0xFFE8EBF2),
    accent: Color(0xFF4F7CFF),
    accentHover: Color(0xFF3B66E8),
    onAccent: Color(0xFFFFFFFF),
    warm: Color(0xFFE7ECFF),
    rose: Color(0xFFF3A6C7),
    blush: Color(0xFF9B7CFF),
    muted: Color(0xFF9B7CFF),
    footer: Color(0xFFFFFFFF),
    success: Color(0xFF3E8F6E),
    error: Color(0xFFC4475A),
    onError: Color(0xFFFFFFFF),
  );

  static const AppPalette dark = AppPalette(
    background: Color(0xFF21171A),
    surface: Color(0xFF2B1D21),
    surfaceElevated: Color(0xFF352328),
    textPrimary: Color(0xFFF8EEE7),
    textSecondary: Color(0xFFC6AAA8),
    border: Color(0xFF51343B),
    accent: Color(0xFF6B93FF),
    accentHover: Color(0xFF8AABFF),
    onAccent: Color(0xFFFFFDFC),
    warm: Color(0xFF4A3338),
    rose: Color(0xFF8A5A62),
    blush: Color(0xFF5C4044),
    muted: Color(0xFFD4A0A8),
    footer: Color(0xFF2A1C20),
    success: Color(0xFF8FB59A),
    error: Color(0xFFD4A0A8),
    onError: Color(0xFF21171A),
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
    required this.warm,
    required this.rose,
    required this.blush,
    required this.muted,
    required this.footer,
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
  final Color warm;
  final Color rose;
  final Color blush;
  final Color muted;
  final Color footer;
  final Color success;
  final Color error;
  final Color onError;

  Color get hoverOverlay => accent.withValues(alpha: 0.10);
  Color get pressedOverlay => accent.withValues(alpha: 0.16);
  Color get scrim => textPrimary.withValues(alpha: 0.28);

  Color projectSurface(int variant) {
    final index = variant.abs() % 3;
    if (textPrimary.computeLuminance() > 0.5) {
      const surfaces = [
        Color(0xFF3A282C),
        Color(0xFF332226),
        Color(0xFF412E32),
      ];
      return surfaces[index];
    }
    return const Color(0xFFFFFFFF);
  }

  LinearGradient get accentGradient => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [accent, blush],
  );

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
      warm: warm,
      rose: rose,
      blush: blush,
      muted: muted,
      footer: footer,
      success: success,
      error: error,
      onError: onError,
    );
  }
}
