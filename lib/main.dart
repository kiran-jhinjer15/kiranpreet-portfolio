import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:kiran_portfolio/app/app.dart';
import 'package:kiran_portfolio/app/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  final themeController = await ThemeController.restore();
  runApp(PortfolioApp(themeController: themeController));
}
