import 'package:flutter/material.dart';

class EntranceTransition extends StatefulWidget {
  const EntranceTransition({
    super.key,
    required this.animation,
    required this.interval,
    required this.child,
    this.begin = const Offset(0, 0.04),
  });

  final Animation<double> animation;
  final Interval interval;
  final Offset begin;
  final Widget child;

  @override
  State<EntranceTransition> createState() => _EntranceTransitionState();
}

class _EntranceTransitionState extends State<EntranceTransition> {
  late CurvedAnimation _curved;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _bind();
  }

  void _bind() {
    _curved = CurvedAnimation(parent: widget.animation, curve: widget.interval);
    _slide = Tween<Offset>(
      begin: widget.begin,
      end: Offset.zero,
    ).animate(_curved);
  }

  @override
  void didUpdateWidget(EntranceTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animation != widget.animation ||
        oldWidget.interval != widget.interval ||
        oldWidget.begin != widget.begin) {
      _curved.dispose();
      _bind();
    }
  }

  @override
  void dispose() {
    _curved.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curved,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
