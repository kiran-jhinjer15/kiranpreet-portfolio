import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/accent_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ProfessionalMode { companies, freelancers }

class ThemeController extends ChangeNotifier {
  ThemeController({
    ThemeMode mode = ThemeMode.light,
    AccentTheme accentTheme = AccentThemes.fallback,
    ProfessionalMode professionalMode = ProfessionalMode.companies,
    SharedPreferences? preferences,
  }) : _mode = mode,
       _accentTheme = accentTheme,
       _professionalMode = professionalMode,
       _preferences = preferences;

  static const String appearanceKey = 'portfolio.appearance';
  static const String accentKey = 'portfolio.accent';
  static const String accentRevisionKey = 'portfolio.accent.revision';
  static const String flutterAccentRevision = 'flutter-blue-1';
  static const String appearanceRevisionKey = 'portfolio.appearance.revision';
  static const String creamAppearanceRevision = 'cream-1';
  static const String professionalModeKey = 'portfolio.mode';

  ThemeMode _mode;
  AccentTheme _accentTheme;
  ProfessionalMode _professionalMode;
  final SharedPreferences? _preferences;

  ThemeMode get mode => _mode;
  AccentTheme get accentTheme => _accentTheme;
  ProfessionalMode get professionalMode => _professionalMode;

  static Future<ThemeController> restore() async {
    final preferences = await SharedPreferences.getInstance();
    final accentId = await _migrateLegacyDefaultAccent(preferences);
    final mode = await _migrateDefaultAppearance(preferences);
    return ThemeController(
      mode: mode,
      accentTheme: AccentThemes.byId(accentId),
      professionalMode: _professionalModeFromName(
        preferences.getString(professionalModeKey),
      ),
      preferences: preferences,
    );
  }

  /// Editorial Burgundy was the previous default. That stored default moves to
  /// Ocean Blue once. Emerald, Violet, Coral, Amber, and a later Burgundy
  /// selection stay put.
  static Future<String?> _migrateLegacyDefaultAccent(
    SharedPreferences preferences,
  ) async {
    final stored = preferences.getString(accentKey);
    if (preferences.getString(accentRevisionKey) == flutterAccentRevision) {
      return stored;
    }
    final accentId = stored == null || stored == AccentThemes.burgundy.id
        ? AccentThemes.oceanBlue.id
        : stored;
    await preferences.setString(accentRevisionKey, flutterAccentRevision);
    await preferences.setString(accentKey, accentId);
    return accentId;
  }

  /// System appearance was the old implicit default, so a dark operating system
  /// opened the portfolio in dark mode. That stored default becomes light once.
  /// An explicit Dark or Light choice is kept, and System can still be selected.
  static Future<ThemeMode> _migrateDefaultAppearance(
    SharedPreferences preferences,
  ) async {
    final stored = preferences.getString(appearanceKey);
    if (preferences.getString(appearanceRevisionKey) != null) {
      return _modeFromName(stored);
    }
    final mode = stored == null || stored == ThemeMode.system.name
        ? ThemeMode.light
        : _modeFromName(stored);
    await preferences.setString(appearanceRevisionKey, creamAppearanceRevision);
    await preferences.setString(appearanceKey, mode.name);
    return mode;
  }

  void setMode(ThemeMode mode) {
    if (_mode == mode) {
      return;
    }
    _mode = mode;
    notifyListeners();
    unawaited(_persist());
  }

  void setAccent(AccentTheme theme) {
    if (_accentTheme.id == theme.id) {
      return;
    }
    _accentTheme = theme;
    notifyListeners();
    unawaited(_persist());
  }

  void setProfessionalMode(ProfessionalMode mode) {
    if (_professionalMode == mode) {
      return;
    }
    _professionalMode = mode;
    notifyListeners();
    unawaited(_persist());
  }

  void toggle(Brightness currentBrightness) {
    setMode(
      currentBrightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }

  Future<void> _persist() async {
    final preferences = _preferences;
    if (preferences == null) {
      return;
    }
    await Future.wait([
      preferences.setString(appearanceKey, _mode.name),
      preferences.setString(accentKey, _accentTheme.id),
      preferences.setString(professionalModeKey, _professionalMode.name),
    ]);
  }

  static ProfessionalMode _professionalModeFromName(String? name) {
    for (final mode in ProfessionalMode.values) {
      if (mode.name == name) {
        return mode;
      }
    }
    return ProfessionalMode.companies;
  }

  static ThemeMode _modeFromName(String? name) {
    for (final mode in ThemeMode.values) {
      if (mode.name == name) {
        return mode;
      }
    }
    return ThemeMode.light;
  }
}

class ThemeScope extends InheritedNotifier<ThemeController> {
  const ThemeScope({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'ThemeScope not found in context');
    return scope!.notifier!;
  }

  static ThemeController? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeScope>()?.notifier;
  }
}
