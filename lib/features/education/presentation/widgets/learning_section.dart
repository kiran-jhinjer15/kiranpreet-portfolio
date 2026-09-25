import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/widgets/entrance_transition.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/education/data/education_data.dart';

class LearningSection extends StatefulWidget {
  const LearningSection({super.key});

  @override
  State<LearningSection> createState() => _LearningSectionState();
}

class _LearningSectionState extends State<LearningSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  ScrollPosition? _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.motionSection,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _tryReveal();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.isCompleted) {
      return;
    }
    final position = Scrollable.maybeOf(context)?.position;
    if (!identical(position, _position)) {
      _position?.removeListener(_tryReveal);
      _position = position;
      _position?.addListener(_tryReveal);
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_tryReveal);
    _controller.dispose();
    super.dispose();
  }

  void _stopListening() {
    _position?.removeListener(_tryReveal);
    _position = null;
  }

  void _tryReveal() {
    if (!mounted) {
      return;
    }
    if (_controller.isCompleted) {
      _stopListening();
      return;
    }
    if (_controller.isAnimating) {
      return;
    }
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
      _stopListening();
      return;
    }
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) {
      return;
    }
    final top = box.localToGlobal(Offset.zero).dy;
    final viewHeight = MediaQuery.sizeOf(context).height;
    if (top < viewHeight - AppSpacing.huge) {
      _controller.forward();
      _stopListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      header: true,
      label: EducationData.learningEyebrow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EntranceTransition(
            animation: _controller,
            interval: const Interval(0, 0.48, curve: Curves.easeOutCubic),
            child: const _LearningIntro(),
          ),
          const SizedBox(height: AppSpacing.xl),
          EntranceTransition(
            animation: _controller,
            interval: const Interval(0.16, 0.62, curve: Curves.easeOutCubic),
            child: const _LearningProgression(),
          ),
          const SizedBox(height: AppSpacing.xxl),
          EntranceTransition(
            animation: _controller,
            interval: const Interval(0.28, 0.7, curve: Curves.easeOutCubic),
            child: const _LearningFocusLabel(),
          ),
          const SizedBox(height: AppSpacing.lg),
          _LearningGrid(animation: _controller),
        ],
      ),
    );
  }
}

class _LearningIntro extends StatelessWidget {
  const _LearningIntro();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = !Responsive.isDesktopOrLarger(context);
    final headingStyle = compact
        ? textTheme.titleLarge
        : textTheme.headlineMedium;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EducationData.learningEyebrow,
            style: textTheme.labelMedium?.copyWith(
              color: colors.accent,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(EducationData.learningHeading, style: headingStyle),
          const SizedBox(height: AppSpacing.lg),
          Text(
            EducationData.learningDescription,
            style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            EducationData.learningContext,
            style: textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _LearningFocusLabel extends StatelessWidget {
  const _LearningFocusLabel();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(EducationData.learningFocusLabel, style: textTheme.titleMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(
          EducationData.learningFocusNote,
          style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }
}

class _LearningProgression extends StatelessWidget {
  const _LearningProgression();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final steps = EducationData.learningProgression;

    return Semantics(
      container: true,
      label: steps.join(', '),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          border: Border.all(color: colors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < steps.length; i++) ...[
                  Text(
                    steps[i],
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  if (i != steps.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: colors.textSecondary,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LearningGrid extends StatelessWidget {
  const _LearningGrid({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 4,
    );
    final areas = EducationData.learningAreas;
    final gap = AppSpacing.lg;
    final rows = <List<LearningArea>>[];

    for (var i = 0; i < areas.length; i += columns) {
      final end = i + columns < areas.length ? i + columns : areas.length;
      rows.add(areas.sublist(i, end));
    }

    return Column(
      children: [
        for (var row = 0; row < rows.length; row++) ...[
          if (row != 0) SizedBox(height: gap),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var column = 0; column < columns; column++) ...[
                  if (column != 0) SizedBox(width: gap),
                  Expanded(
                    child: column < rows[row].length
                        ? EntranceTransition(
                            animation: animation,
                            interval: _stagger(row * columns + column),
                            child: _LearningAreaCard(area: rows[row][column]),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  Interval _stagger(int index) {
    return Interval(
      (0.34 + index * 0.05).clamp(0.0, 0.78),
      (0.68 + index * 0.04).clamp(0.72, 1.0),
      curve: Curves.easeOutCubic,
    );
  }
}

class _LearningAreaCard extends StatefulWidget {
  const _LearningAreaCard({required this.area});

  final LearningArea area;

  @override
  State<_LearningAreaCard> createState() => _LearningAreaCardState();
}

class _LearningAreaCardState extends State<_LearningAreaCard> {
  bool _hovered = false;

  bool get _hoverEnabled => !Responsive.isMobile(context);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final area = widget.area;

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
      child: AnimatedSlide(
        offset: _hovered ? const Offset(0, -0.01) : Offset.zero,
        duration: AppConstants.motionTheme,
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: AppConstants.motionTheme,
          curve: Curves.easeOut,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
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
                blurRadius: _hovered ? 12 : 6,
                offset: Offset(0, _hovered ? 5 : 2),
              ),
            ],
          ),
          child: Row(
            children: [
              ExcludeSemantics(
                child: Icon(area.icon, size: 18, color: colors.accent),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text(area.label, style: textTheme.titleMedium)),
            ],
          ),
        ),
      ),
    );
  }
}
