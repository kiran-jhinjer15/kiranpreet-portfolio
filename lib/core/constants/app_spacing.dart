import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
  static const double huge = 64;
  static const double section = 80;
  static const double sectionLarge = 96;

  static const double navbarHeight = 76;
  static const double tapTarget = 44;

  static double pageHorizontal(BuildContext context) {
    return Responsive.value<double>(
      context,
      mobile: xl,
      tablet: xxl,
      desktop: xxxl,
      largeDesktop: huge,
    );
  }

  static double sectionVertical(BuildContext context) {
    return Responsive.value<double>(
      context,
      mobile: huge,
      tablet: section,
      desktop: sectionLarge,
    );
  }
}
