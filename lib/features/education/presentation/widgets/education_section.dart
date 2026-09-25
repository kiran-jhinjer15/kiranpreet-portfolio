import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/widgets/entrance_transition.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/widgets/app_section.dart';
import 'package:kiran_portfolio/features/education/data/education_data.dart';
import 'package:kiran_portfolio/features/education/presentation/widgets/education_card.dart';
import 'package:kiran_portfolio/features/education/presentation/widgets/learning_section.dart';

class EducationSection extends StatefulWidget {
  const EducationSection({super.key});

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection>
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
    final colors = AppColors.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: AppSection(
        child: Semantics(
          container: true,
          header: true,
          label: EducationData.eyebrow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EntranceTransition(
                animation: _controller,
                interval: const Interval(0, 0.52, curve: Curves.easeOutCubic),
                child: const _EducationIntro(),
              ),
              const SizedBox(height: AppSpacing.xxl),
              _EducationGrid(animation: _controller),
              const SizedBox(height: AppSpacing.huge),
              Divider(color: colors.border, height: 1),
              const SizedBox(height: AppSpacing.huge),
              const LearningSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EducationIntro extends StatelessWidget {
  const _EducationIntro();

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
            EducationData.eyebrow,
            style: textTheme.labelMedium?.copyWith(
              color: colors.accent,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(EducationData.heading, style: headingStyle),
          const SizedBox(height: AppSpacing.lg),
          Text(
            EducationData.description,
            style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _EducationGrid extends StatelessWidget {
  const _EducationGrid({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
    final items = EducationData.items;
    final gap = AppSpacing.lg;
    final rows = <List<EducationItem>>[];

    for (var i = 0; i < items.length; i += columns) {
      final end = i + columns < items.length ? i + columns : items.length;
      rows.add(items.sublist(i, end));
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
                            child: EducationCard(item: rows[row][column]),
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
      (0.2 + index * 0.1).clamp(0.0, 0.7),
      (0.62 + index * 0.1).clamp(0.75, 1.0),
      curve: Curves.easeOutCubic,
    );
  }
}
