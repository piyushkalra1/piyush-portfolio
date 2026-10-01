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
  final ValueNotifier<Offset> _mousePos = ValueNotifier<Offset>(Offset.zero);
  final ValueNotifier<bool> _isHovered = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _mousePos.dispose();
    _isHovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return MouseRegion(
        onEnter: (_) => _isHovered.value = true,
        onExit: (_) => _isHovered.value = false,
        onHover: (event) {
          _mousePos.value = event.localPosition;
        },
        child: Stack(
          children: [
            RepaintBoundary(
              child: widget.child,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isHovered,
              builder: (context, hovered, _) {
                if (!hovered) return const SizedBox.shrink();
                return Positioned.fill(
                  child: IgnorePointer(
                    child: RepaintBoundary(
                      child: ValueListenableBuilder<Offset>(
                        valueListenable: _mousePos,
                        builder: (context, pos, _) {
                          return CustomPaint(
                            painter: _GlowPainter(mousePosition: pos),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
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
          AppColors.primaryAccent.withOpacity(0.09),
          AppColors.secondaryAccent.withOpacity(0.03),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
        radius: 0.28,
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
