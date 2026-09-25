import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';

abstract final class SectionScroll {
  static const Curve curve = Curves.easeInOut;

  static Future<void> to(
    BuildContext? targetContext, {
    double alignment = 0,
    double topInset = 0,
  }) async {
    if (targetContext == null || !targetContext.mounted) {
      return;
    }

    if (topInset <= 0) {
      await Scrollable.ensureVisible(
        targetContext,
        alignment: alignment,
        duration: AppConstants.motionSection,
        curve: curve,
      );
      return;
    }

    final scrollable = Scrollable.maybeOf(targetContext);
    final box = targetContext.findRenderObject();
    if (scrollable == null || box is! RenderBox || !box.hasSize) {
      return;
    }

    final position = scrollable.position;
    final targetOffset =
        position.pixels + box.localToGlobal(Offset.zero).dy - topInset;
    final clamped = targetOffset.clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    await position.animateTo(
      clamped,
      duration: AppConstants.motionSection,
      curve: curve,
    );
  }

  static const double activationLine = AppSpacing.navbarHeight + AppSpacing.xl;
}
