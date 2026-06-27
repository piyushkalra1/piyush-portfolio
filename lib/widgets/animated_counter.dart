import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedCounter extends StatefulWidget {
  final int targetValue;
  final String suffix;
  final TextStyle style;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    this.suffix = "",
    required this.style,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0, end: widget.targetValue.toDouble()).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_hasStarted) {
      setState(() {
        _hasStarted = true;
      });
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('counter_${widget.targetValue}_${widget.suffix}'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.2) {
          _startAnimation();
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final currentValue = _animation.value.round();
          return Text(
            '$currentValue${widget.suffix}',
            style: widget.style,
          );
        },
      ),
    );
  }
}
