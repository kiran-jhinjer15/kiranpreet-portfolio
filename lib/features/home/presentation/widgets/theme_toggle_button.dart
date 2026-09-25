import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';

class MenuToggleButton extends StatelessWidget {
  const MenuToggleButton({
    super.key,
    required this.isOpen,
    required this.onPressed,
  });

  final bool isOpen;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final tooltip = isOpen ? 'Close menu' : 'Open menu';

    return Semantics(
      button: true,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        ignorePointer: true,
        preferBelow: false,
        waitDuration: AppConstants.motionMedium,
        child: IconButton(
          onPressed: onPressed,
          icon: AnimatedSwitcher(
            duration: AppConstants.motionFast,
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: Icon(
              isOpen ? Icons.close : Icons.menu,
              key: ValueKey(isOpen),
              color: colors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
