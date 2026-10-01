import 'package:flutter/material.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';

class WorkDirectionCard extends StatefulWidget {
  const WorkDirectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.cta,
    required this.onPressed,
    this.emphasized = false,
  });

  final String title;
  final String subtitle;
  final String description;
  final String cta;
  final VoidCallback onPressed;
  final bool emphasized;

  @override
  State<WorkDirectionCard> createState() => _WorkDirectionCardState();
}

class _WorkDirectionCardState extends State<WorkDirectionCard> {
  bool _hovered = false;

  bool get _hoverEnabled => !Responsive.isMobile(context);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final hovered = _hoverEnabled && _hovered;

    return Tooltip(
      message: widget.cta,
      excludeFromSemantics: true,
      child: MouseRegion(
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
        cursor: SystemMouseCursors.click,
        child: AnimatedSlide(
          offset: hovered ? const Offset(0, -0.012) : Offset.zero,
          duration: AppConstants.motionTheme,
          curve: Curves.easeOut,
          child: Semantics(
            button: true,
            label: '${widget.title}. ${widget.subtitle}. ${widget.cta}',
            child: Material(
              color: colors.background.withValues(alpha: 0),
              child: InkWell(
                onTap: widget.onPressed,
                borderRadius: BorderRadius.circular(AppSpacing.sm),
                hoverColor: colors.hoverOverlay,
                focusColor: colors.hoverOverlay,
                child: AnimatedContainer(
                  duration: AppConstants.motionTheme,
                  curve: Curves.easeOut,
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: widget.emphasized
                        ? colors.surface
                        : colors.surfaceElevated,
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                    border: Border.all(
                      color: hovered || widget.emphasized
                          ? colors.accent.withValues(alpha: hovered ? 0.7 : 0.4)
                          : colors.border,
                      width: widget.emphasized ? 1.5 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.textPrimary.withValues(
                          alpha: hovered ? 0.07 : 0.03,
                        ),
                        blurRadius: hovered ? 18 : 8,
                        offset: Offset(0, hovered ? 8 : 3),
                      ),
                    ],
                  ),
                  child: ExcludeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.subtitle,
                          style: textTheme.labelMedium?.copyWith(
                            color: colors.accent,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(widget.title, style: textTheme.headlineSmall),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          widget.description,
                          style: textTheme.bodyLarge?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          widget.cta,
                          style: textTheme.labelLarge?.copyWith(
                            color: colors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
