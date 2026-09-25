import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';

class ContactDetailCard extends StatefulWidget {
  const ContactDetailCard({
    super.key,
    required this.label,
    required this.value,
    required this.leading,
    this.onPressed,
    this.trailing,
    this.selectableValue = false,
  });

  final String label;
  final String value;
  final Widget leading;
  final VoidCallback? onPressed;
  final Widget? trailing;
  final bool selectableValue;

  @override
  State<ContactDetailCard> createState() => _ContactDetailCardState();
}

class _ContactDetailCardState extends State<ContactDetailCard> {
  bool _hovered = false;

  bool get _hoverEnabled => !Responsive.isMobile(context);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final tappable = widget.onPressed != null;

    return MouseRegion(
      onEnter: (_) {
        if (_hoverEnabled) {
          setState(() => _hovered = true);
        }
      },
      onExit: (_) {
        if (_hovered) {
          setState(() => _hovered = false);
        }
      },
      cursor: tappable ? SystemMouseCursors.click : MouseCursor.defer,
      child: AnimatedContainer(
        duration: AppConstants.motionTheme,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: colors.surfaceElevated,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          border: Border.all(
            color: _hovered
                ? colors.accent.withValues(alpha: 0.45)
                : colors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.textPrimary.withValues(
                alpha: _hovered ? 0.06 : 0.03,
              ),
              blurRadius: _hovered ? 14 : 8,
              offset: Offset(0, _hovered ? 6 : 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Semantics(
                button: tappable,
                label: '${widget.label}, ${widget.value}',
                child: InkWell(
                  onTap: widget.onPressed,
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                  hoverColor: colors.hoverOverlay,
                  focusColor: colors.hoverOverlay,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: ExcludeSemantics(
                      child: Row(
                        children: [
                          IconTheme(
                            data: IconThemeData(size: 18, color: colors.accent),
                            child: widget.leading,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.label,
                                  style: textTheme.labelMedium?.copyWith(
                                    color: colors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                widget.selectableValue
                                    ? SelectableText(
                                        widget.value,
                                        style: textTheme.titleMedium,
                                      )
                                    : Text(
                                        widget.value,
                                        style: textTheme.titleMedium,
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.trailing != null)
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: widget.trailing,
              ),
          ],
        ),
      ),
    );
  }
}
