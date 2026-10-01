import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/widgets/app_content.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/editorial_layout.dart';

class AppSection extends StatelessWidget {
  const AppSection({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final embedded = EditorialScope.of(context);
    return AppContent(
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: embedded ? 0 : AppSpacing.pageHorizontal(context),
            vertical: AppSpacing.sectionVertical(context),
          ),
      child: child,
    );
  }
}
