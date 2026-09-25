import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';

class AppContent extends StatelessWidget {
  const AppContent({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppConstants.maxContentWidth,
        ),
        child: Padding(
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHorizontal(context),
              ),
          child: child,
        ),
      ),
    );
  }
}
