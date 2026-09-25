import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/navigation/section_request.dart';
import 'package:kiran_portfolio/features/about/presentation/about_page.dart';
import 'package:kiran_portfolio/features/contact/presentation/contact_page.dart';
import 'package:kiran_portfolio/features/experience/presentation/experience_page.dart';
import 'package:kiran_portfolio/features/home/presentation/home_page.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/pages/project_case_study_page.dart';
import 'package:kiran_portfolio/features/projects/presentation/projects_page.dart';

abstract final class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String projects = '/projects';
  static const String experience = '/experience';
  static const String contact = '/contact';

  static const List<String> all = [home, about, projects, experience, contact];

  static String normalize(String path) {
    if (path.isEmpty) {
      return home;
    }

    var normalized = path;
    if (normalized.length > 1 && normalized.endsWith('/')) {
      normalized = normalized.substring(0, normalized.length - 1);
    }

    if (all.contains(normalized) ||
        ProjectsData.byCaseStudyRoute(normalized) != null) {
      return normalized;
    }

    return home;
  }

  static Widget pageFor(String path) {
    final normalized = normalize(path);
    final caseStudy = ProjectsData.byCaseStudyRoute(normalized);
    if (caseStudy != null) {
      return ProjectCaseStudyPage(
        project: caseStudy,
        onBack: () => AppRouter.go(home),
      );
    }

    return switch (normalized) {
      about => const AboutPage(),
      projects => const ProjectsPage(),
      experience => const ExperiencePage(),
      contact => const ContactPage(),
      _ => const HomePage(),
    };
  }
}

abstract final class AppRouter {
  static final AppRouterDelegate delegate = AppRouterDelegate();

  static RouterConfig<String>? _config;

  static RouterConfig<String> get config {
    return _config ??= RouterConfig<String>(
      routeInformationProvider: PlatformRouteInformationProvider(
        initialRouteInformation: RouteInformation(
          uri: Uri.parse(
            WidgetsBinding.instance.platformDispatcher.defaultRouteName,
          ),
        ),
      ),
      routeInformationParser: const AppRouteInformationParser(),
      routerDelegate: delegate,
    );
  }

  static void go(String path) => delegate.go(path);

  @visibleForTesting
  static void reset() {
    delegate.resetToHome();
  }
}

class AppRouteInformationParser extends RouteInformationParser<String> {
  const AppRouteInformationParser();

  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) {
    return SynchronousFuture(AppRoutes.normalize(routeInformation.uri.path));
  }

  @override
  RouteInformation restoreRouteInformation(String configuration) {
    return RouteInformation(uri: Uri(path: configuration));
  }
}

class AppRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String _path = AppRoutes.home;

  @override
  String get currentConfiguration => _path;

  void go(String path) {
    final normalized = AppRoutes.normalize(path);
    if (_path == normalized) {
      return;
    }
    _path = normalized;
    notifyListeners();
  }

  @visibleForTesting
  void resetToHome() {
    _path = AppRoutes.home;
    SectionRequest.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage<void>(
          key: ValueKey(_path),
          child: AppRoutes.pageFor(_path),
        ),
      ],
      onDidRemovePage: (page) {
        final key = page.key;
        if (key is! ValueKey<String> || key.value != _path) {
          return;
        }
        if (_path == AppRoutes.home) {
          return;
        }
        _path = AppRoutes.home;
        notifyListeners();
      },
    );
  }

  @override
  Future<void> setNewRoutePath(String configuration) {
    _path = AppRoutes.normalize(configuration);
    return SynchronousFuture(null);
  }
}
