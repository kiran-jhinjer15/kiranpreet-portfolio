import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/widgets/app_content.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_sidebar.dart';

class EditorialScope extends InheritedWidget {
  const EditorialScope({super.key, required super.child});

  static bool of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EditorialScope>() != null;
  }

  @override
  bool updateShouldNotify(EditorialScope oldWidget) => false;
}

class EditorialLayout extends StatelessWidget {
  const EditorialLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return child;
    }

    final sidebarWidth = Responsive.value<double>(
      context,
      mobile: 0,
      tablet: 196,
      desktop: 232,
    );

    return EditorialScope(
      child: AppContent(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.pageHorizontal(context),
          AppSpacing.xxl,
          AppSpacing.pageHorizontal(context),
          0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: sidebarWidth, child: const PortfolioSidebar()),
            const SizedBox(width: AppSpacing.xl),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
