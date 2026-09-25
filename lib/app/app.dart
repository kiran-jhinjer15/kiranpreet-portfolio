import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/routes/app_routes.dart';
import 'package:kiran_portfolio/app/theme/app_theme.dart';
import 'package:kiran_portfolio/app/theme/theme_controller.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key, this.themeController});

  final ThemeController? themeController;

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  late final ThemeController _themeController;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.themeController == null;
    _themeController = widget.themeController ?? ThemeController();
    _themeController.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    _themeController.removeListener(_onThemeChanged);
    if (_ownsController) {
      _themeController.dispose();
    }
    super.dispose();
  }

  void _onThemeChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final accent = _themeController.accentTheme;

    return ThemeScope(
      controller: _themeController,
      child: MaterialApp.router(
        title: AppConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(accent: accent),
        darkTheme: AppTheme.dark(accent: accent),
        themeMode: _themeController.mode,
        themeAnimationDuration: AppConstants.motionTheme,
        themeAnimationCurve: Curves.easeInOut,
        routerConfig: AppRouter.config,
      ),
    );
  }
}
