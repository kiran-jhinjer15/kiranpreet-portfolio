import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';

class SectionNavigator extends InheritedWidget {
  const SectionNavigator({
    super.key,
    required this.keys,
    required this.scrollTo,
    required this.scrollToTop,
    this.activeSection,
    required super.child,
  });

  final Map<PortfolioSection, GlobalKey> keys;
  final Future<void> Function(PortfolioSection section) scrollTo;
  final VoidCallback scrollToTop;
  final PortfolioSection? activeSection;

  static SectionNavigator of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<SectionNavigator>();
    assert(scope != null, 'SectionNavigator not found in context');
    return scope!;
  }

  static SectionNavigator? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SectionNavigator>();
  }

  GlobalKey keyFor(PortfolioSection section) => keys[section]!;

  bool isAttached(PortfolioSection section) {
    return keys[section]?.currentContext != null;
  }

  @override
  bool updateShouldNotify(SectionNavigator oldWidget) {
    return keys != oldWidget.keys || activeSection != oldWidget.activeSection;
  }
}
