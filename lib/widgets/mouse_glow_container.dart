import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';

class MouseGlowContainer extends StatefulWidget {
  final Widget child;
  const MouseGlowContainer({super.key, required this.child});

  @override
  State<MouseGlowContainer> createState() => _MouseGlowContainerState();
}

class _MouseGlowContainerState extends State<MouseGlowContainer> {
  Offset _mousePos = Offset.zero;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Only enable mouse glow on web/desktop and when pointer events are available
    if (kIsWeb) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        onHover: (event) {
          setState(() {
            _mousePos = event.localPosition;
          });
        },
        child: Stack(
          children: [
            widget.child,
            if (_isHovered)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _GlowPainter(mousePosition: _mousePos),
                  ),
                ),
              ),
          ],
        ),
      );
    }
    return widget.child;
  }
}

class _GlowPainter extends CustomPainter {
  final Offset mousePosition;
  _GlowPainter({required this.mousePosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primaryAccent.withOpacity(0.08),
          AppColors.secondaryAccent.withOpacity(0.03),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
        radius: 0.25,
      ).createShader(Rect.fromLTWH(
        mousePosition.dx - size.width,
        mousePosition.dy - size.width,
        size.width * 2,
        size.width * 2,
      ));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(_GlowPainter oldDelegate) {
    return oldDelegate.mousePosition != mousePosition;
  }
}
