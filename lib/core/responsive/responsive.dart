import 'package:flutter/widgets.dart';
import 'package:kiran_portfolio/core/responsive/responsive_breakpoints.dart';

abstract final class Responsive {
  static double screenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static bool isMobile(BuildContext context) {
    return screenWidth(context) < ResponsiveBreakpoints.mobile;
  }

  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= ResponsiveBreakpoints.mobile &&
        width < ResponsiveBreakpoints.tablet;
  }

  static bool isDesktop(BuildContext context) {
    final width = screenWidth(context);
    return width >= ResponsiveBreakpoints.tablet &&
        width < ResponsiveBreakpoints.desktop;
  }

  static bool isLargeDesktop(BuildContext context) {
    return screenWidth(context) >= ResponsiveBreakpoints.desktop;
  }

  static bool isDesktopOrLarger(BuildContext context) {
    return screenWidth(context) >= ResponsiveBreakpoints.tablet;
  }

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    if (isLargeDesktop(context)) {
      return largeDesktop ?? desktop ?? tablet ?? mobile;
    }
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    }
    if (isTablet(context)) {
      return tablet ?? mobile;
    }
    return mobile;
  }
}
