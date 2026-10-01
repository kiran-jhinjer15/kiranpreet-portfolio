import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/navigation/section_navigator.dart';
import 'package:kiran_portfolio/features/home/presentation/hero_copy.dart';
import 'package:kiran_portfolio/features/profile/presentation/profile_copy.dart';

class PortfolioSidebar extends StatelessWidget {
  const PortfolioSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final navigator = SectionNavigator.maybeOf(context);
    final active = navigator?.activeSection;

    return _PinnedSidebar(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          border: Border.all(color: colors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.xl,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _Monogram(name: HeroCopy.name),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(HeroCopy.name, style: textTheme.titleMedium),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          ProfileCopy.role,
                          style: textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Divider(color: colors.border, height: 1),
              const SizedBox(height: AppSpacing.sm),
              _SideLink(
                label: 'Home',
                selected: active == null,
                onPressed: navigator?.scrollToTop ?? () {},
              ),
              for (final section in PortfolioSection.values)
                _SideLink(
                  key: ValueKey('section-nav-${section.id}'),
                  label: section.label,
                  selected: active == section,
                  onPressed: () => navigator?.scrollTo(section),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Monogram extends StatelessWidget {
  const _Monogram({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final initials = name
        .split(' ')
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0])
        .join();

    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.background,
        border: Border.all(color: colors.border),
      ),
      child: Text(
        initials,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: colors.accent),
      ),
    );
  }
}

class _SideLink extends StatelessWidget {
  const _SideLink({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        hoverColor: colors.hoverOverlay,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppSpacing.tapTarget),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: AppConstants.motionFast,
                  width: 3,
                  height: 16,
                  decoration: BoxDecoration(
                    color: selected ? colors.accent : colors.surface,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: selected ? colors.accent : colors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PinnedSidebar extends StatefulWidget {
  const _PinnedSidebar({required this.child});

  final Widget child;

  @override
  State<_PinnedSidebar> createState() => _PinnedSidebarState();
}

class _PinnedSidebarState extends State<_PinnedSidebar> {
  final GlobalKey _anchorKey = GlobalKey();
  double _offset = 0;

  bool _onScroll(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) {
      return false;
    }
    final anchor = _anchorKey.currentContext?.findRenderObject();
    final viewport = notification.context?.findRenderObject();
    if (anchor is! RenderBox || viewport is! RenderBox) {
      return false;
    }
    if (!anchor.hasSize || !viewport.hasSize || !anchor.attached) {
      return false;
    }
    final top = anchor.localToGlobal(Offset.zero, ancestor: viewport).dy;
    final row = context.findAncestorRenderObjectOfType<RenderFlex>();
    var maxOffset = math.max(0.0, AppSpacing.lg - top);
    if (row != null && row.hasSize && row.attached) {
      final rowTop = row.localToGlobal(Offset.zero, ancestor: viewport).dy;
      final sidebar = context.findRenderObject();
      final sidebarHeight = sidebar is RenderBox && sidebar.hasSize
          ? sidebar.size.height
          : 0.0;
      final limit = row.size.height - sidebarHeight + rowTop - AppSpacing.lg;
      maxOffset = maxOffset.clamp(0.0, math.max(0.0, limit));
    }
    if ((maxOffset - _offset).abs() > 0.5 && mounted) {
      setState(() => _offset = maxOffset);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(key: _anchorKey, height: 0),
          Transform.translate(offset: Offset(0, _offset), child: widget.child),
        ],
      ),
    );
  }
}
