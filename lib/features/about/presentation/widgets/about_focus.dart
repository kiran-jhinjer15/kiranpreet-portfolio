import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/features/about/presentation/about_copy.dart';

class AboutFocus extends StatelessWidget {
  const AboutFocus({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: colors.textPrimary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final area in AboutCopy.focusAreas)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 12,
                  height: 2,
                  margin: const EdgeInsets.only(top: 9),
                  color: colors.accent,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: Text(area, style: textStyle)),
              ],
            ),
          ),
      ],
    );
  }
}
