import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_spacing.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/navigation/section_request.dart';
import 'package:kiran_portfolio/core/navigation/section_navigator.dart';
import 'package:kiran_portfolio/core/navigation/section_scroll.dart';
import 'package:kiran_portfolio/core/responsive/responsive.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/mobile_nav_menu.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_navbar.dart';

class PortfolioShell extends StatefulWidget {
  const PortfolioShell({
    super.key,
    this.body = const SizedBox.shrink(),
    this.onUnavailableSection,
  });

  final Widget body;

  final void Function(PortfolioSection section)? onUnavailableSection;

  @override
  State<PortfolioShell> createState() => _PortfolioShellState();
}

class _PortfolioShellState extends State<PortfolioShell> {
  final ScrollController _scrollController = ScrollController();
  late final Map<PortfolioSection, GlobalKey> _sectionKeys;

  bool _isScrolled = false;
  bool _isMenuOpen = false;
  PortfolioSection? _activeSection;

  @override
  void initState() {
    super.initState();
    _sectionKeys = {
      for (final section in PortfolioSection.values) section: GlobalKey(),
    };
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final section = SectionRequest.take();
      if (section != null) {
        _scrollWhenReady(section);
      }
    });
  }

  void _scrollWhenReady(PortfolioSection section, [int attempt = 0]) {
    if (!mounted) {
      return;
    }
    if (_sectionKeys[section]?.currentContext == null && attempt < 4) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollWhenReady(section, attempt + 1);
      });
      return;
    }
    _scrollToSection(section);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final isScrolled =
        _scrollController.hasClients &&
        _scrollController.offset > AppSpacing.sm;
    final activeSection = _detectActiveSection();
    if (isScrolled != _isScrolled || activeSection != _activeSection) {
      setState(() {
        _isScrolled = isScrolled;
        _activeSection = activeSection;
      });
    }
  }

  PortfolioSection? _detectActiveSection() {
    PortfolioSection? current;
    for (final section in PortfolioSection.values) {
      final sectionContext = _sectionKeys[section]?.currentContext;
      if (sectionContext == null) {
        continue;
      }
      final box = sectionContext.findRenderObject();
      if (box is! RenderBox || !box.hasSize) {
        continue;
      }
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= SectionScroll.activationLine) {
        current = section;
      }
    }
    return current;
  }

  void _closeMenu() {
    if (!_isMenuOpen) {
      return;
    }
    setState(() => _isMenuOpen = false);
  }

  void _toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  void _scrollToTop() {
    _closeMenu();
    if (!_scrollController.hasClients) {
      return;
    }
    _scrollController.animateTo(
      0,
      duration: AppConstants.motionSection,
      curve: SectionScroll.curve,
    );
    if (_activeSection != null) {
      setState(() => _activeSection = null);
    }
  }

  Future<void> _scrollToSection(PortfolioSection section) async {
    _closeMenu();
    final targetContext = _sectionKeys[section]?.currentContext;
    if (targetContext == null) {
      widget.onUnavailableSection?.call(section);
      return;
    }
    if (_activeSection != section) {
      setState(() => _activeSection = section);
    }
    await SectionScroll.to(targetContext);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isCompact = !Responsive.isDesktopOrLarger(context);
    final showMenu = isCompact && _isMenuOpen;

    if (!isCompact && _isMenuOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _closeMenu();
        }
      });
    }

    return SectionNavigator(
      keys: _sectionKeys,
      scrollTo: _scrollToSection,
      scrollToTop: _scrollToTop,
      activeSection: _activeSection,
      child: Shortcuts(
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
        },
        child: Actions(
          actions: {
            DismissIntent: CallbackAction<DismissIntent>(
              onInvoke: (_) {
                _closeMenu();
                return null;
              },
            ),
          },
          child: Scaffold(
            backgroundColor: colors.background,
            body: Column(
              children: [
                PortfolioNavbar(
                  isScrolled: _isScrolled,
                  isMenuOpen: _isMenuOpen,
                  activeSection: _activeSection,
                  onBrandTap: _scrollToTop,
                  onSectionSelected: _scrollToSection,
                  onMenuToggle: _toggleMenu,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            controller: _scrollController,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                              ),
                              child: widget.body,
                            ),
                          );
                        },
                      ),
                      if (showMenu) ...[
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: _closeMenu,
                            behavior: HitTestBehavior.opaque,
                            child: ColoredBox(color: colors.scrim),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: MobileNavMenu(
                            activeSection: _activeSection,
                            onSectionSelected: _scrollToSection,
                          ),
                        ),
                      ],
                    ],
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
