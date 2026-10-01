import 'package:flutter/material.dart';

final class AccentTheme {
  const AccentTheme({
    required this.id,
    required this.name,
    required this.accent,
    required this.accentHover,
    this.lightAccent,
    this.darkAccent,
    this.lightAccentHover,
    this.darkAccentHover,
  });

  final String id;
  final String name;
  final Color accent;
  final Color accentHover;
  final Color? lightAccent;
  final Color? darkAccent;
  final Color? lightAccentHover;
  final Color? darkAccentHover;

  Color resolvedAccent(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return darkAccent ?? accent;
    }
    return lightAccent ?? accent;
  }

  Color resolvedHover(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return darkAccentHover ?? accentHover;
    }
    return lightAccentHover ?? accentHover;
  }
}

abstract final class AccentThemes {
  static const AccentTheme burgundy = AccentTheme(
    id: 'editorial-burgundy',
    name: 'Editorial Burgundy',
    accent: Color(0xFF641B28),
    accentHover: Color(0xFF48131D),
    darkAccent: Color(0xFFC9828B),
    darkAccentHover: Color(0xFFD4A0A8),
  );

  static const AccentTheme oceanBlue = AccentTheme(
    id: 'ocean-blue',
    name: 'Ocean Blue',
    accent: Color(0xFF4F7CFF),
    accentHover: Color(0xFF3B66E8),
    darkAccent: Color(0xFF6B93FF),
    darkAccentHover: Color(0xFF8AABFF),
  );

  static const AccentTheme emerald = AccentTheme(
    id: 'emerald',
    name: 'Emerald',
    accent: Color(0xFF16A085),
    accentHover: Color(0xFF1ABC9C),
  );

  static const AccentTheme violet = AccentTheme(
    id: 'violet',
    name: 'Violet',
    accent: Color(0xFF8B5CF6),
    accentHover: Color(0xFFA78BFA),
  );

  static const AccentTheme coral = AccentTheme(
    id: 'coral',
    name: 'Coral',
    accent: Color(0xFFFF6B5E),
    accentHover: Color(0xFFFF8278),
  );

  static const AccentTheme amber = AccentTheme(
    id: 'amber',
    name: 'Amber',
    accent: Color(0xFFD99A00),
    accentHover: Color(0xFFF0B429),
  );

  static const List<AccentTheme> all = [
    oceanBlue,
    burgundy,
    emerald,
    violet,
    coral,
    amber,
  ];

  static const AccentTheme fallback = oceanBlue;

  static AccentTheme byId(String? id) {
    for (final theme in all) {
      if (theme.id == id) {
        return theme;
      }
    }
    return fallback;
  }
}
