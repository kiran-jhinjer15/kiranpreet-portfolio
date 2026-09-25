import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/accent_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController({
    ThemeMode mode = ThemeMode.system,
    AccentTheme accentTheme = AccentThemes.fallback,
    SharedPreferences? preferences,
  }) : _mode = mode,
       _accentTheme = accentTheme,
       _preferences = preferences;

  static const String appearanceKey = 'portfolio.appearance';
  static const String accentKey = 'portfolio.accent';

  ThemeMode _mode;
  AccentTheme _accentTheme;
  final SharedPreferences? _preferences;

  ThemeMode get mode => _mode;
  AccentTheme get accentTheme => _accentTheme;

  static Future<ThemeController> restore() async {
    final preferences = await SharedPreferences.getInstance();
    return ThemeController(
      mode: _modeFromName(preferences.getString(appearanceKey)),
      accentTheme: AccentThemes.byId(preferences.getString(accentKey)),
      preferences: preferences,
    );
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
    ]);
  }

  static ThemeMode _modeFromName(String? name) {
    for (final mode in ThemeMode.values) {
      if (mode.name == name) {
        return mode;
      }
    }
    return ThemeMode.system;
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
