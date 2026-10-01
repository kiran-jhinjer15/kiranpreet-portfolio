import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';

abstract final class AppTextStyles {
  static const String fontFamily = 'Roboto';

  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w600,
    height: 1.08,
    letterSpacing: -0.6,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: 1.12,
    letterSpacing: -0.4,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.4,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.2,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.2,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.35,
    letterSpacing: 0,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    letterSpacing: 0,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.55,
    letterSpacing: 0.1,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.1,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.2,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.3,
  );

  static TextTheme textTheme(AppPalette palette) {
    return TextTheme(
      displayLarge: displayLarge.copyWith(color: palette.textPrimary),
      displayMedium: displayMedium.copyWith(color: palette.textPrimary),
      headlineLarge: headlineLarge.copyWith(color: palette.textPrimary),
      headlineMedium: headlineMedium.copyWith(color: palette.textPrimary),
      titleLarge: titleLarge.copyWith(color: palette.textPrimary),
      titleMedium: titleMedium.copyWith(color: palette.textPrimary),
      bodyLarge: bodyLarge.copyWith(color: palette.textSecondary),
      bodyMedium: bodyMedium.copyWith(color: palette.textSecondary),
      bodySmall: bodySmall.copyWith(color: palette.textSecondary),
      labelLarge: labelLarge.copyWith(color: palette.textPrimary),
      labelMedium: labelMedium.copyWith(color: palette.textSecondary),
    );
  }
}
