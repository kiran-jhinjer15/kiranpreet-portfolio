import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/navigation/section_navigator.dart';

class SectionAnchor extends StatelessWidget {
  const SectionAnchor({super.key, required this.section, required this.child});

  final PortfolioSection section;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: SectionNavigator.of(context).keyFor(section),
      child: child,
    );
  }
}
