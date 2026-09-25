import 'package:flutter/material.dart';
import 'package:kiran_portfolio/core/widgets/entrance_transition.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/core/widgets/app_section.dart';
import 'package:kiran_portfolio/core/widgets/section_anchor.dart';
import 'package:kiran_portfolio/features/skills/presentation/data/skills_data.dart';
import 'package:kiran_portfolio/features/skills/presentation/widgets/skill_category_card.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
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

    return SectionAnchor(
      section: PortfolioSection.skills,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: AppSection(
          child: Semantics(
            container: true,
            header: true,
            label: SkillsData.eyebrow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                EntranceTransition(
                  animation: _controller,
                  interval: const Interval(0, 0.62, curve: Curves.easeOutCubic),
                  child: const _SkillsIntro(),
                ),
                const SizedBox(height: AppSpacing.xxxl),
                _SkillsGrid(animation: _controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillsIntro extends StatelessWidget {
  const _SkillsIntro();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final compact = !Responsive.isDesktopOrLarger(context);
    final headingStyle = compact
        ? textTheme.headlineMedium
        : textTheme.headlineLarge;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 720),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            SkillsData.eyebrow,
            style: textTheme.labelMedium?.copyWith(
              color: colors.accent,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(SkillsData.heading, style: headingStyle),
          const SizedBox(height: AppSpacing.lg),
          Text(
            SkillsData.description,
            style: textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  const _SkillsGrid({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
    final categories = SkillsData.categories;
    final gap = AppSpacing.lg;
    final rows = <List<SkillCategory>>[];

    for (var i = 0; i < categories.length; i += columns) {
      final end = i + columns < categories.length
          ? i + columns
          : categories.length;
      rows.add(categories.sublist(i, end));
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
                            child: SkillCategoryCard(
                              category: rows[row][column],
                            ),
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
      (0.16 + index * 0.08).clamp(0.0, 0.72),
      (0.58 + index * 0.08).clamp(0.7, 1.0),
      curve: Curves.easeOutCubic,
    );
  }
}
