import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/widgets/app_content.dart';

class AppSection extends StatelessWidget {
  const AppSection({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AppContent(
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: AppSpacing.pageHorizontal(context),
            vertical: AppSpacing.sectionVertical(context),
          ),
      child: child,
    );
  }
}
