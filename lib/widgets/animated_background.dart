import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_StarParticle> _stars = [];
  final math.Random _random = math.Random(42);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Generate static seed particles
    for (int i = 0; i < 45; i++) {
      _stars.add(_StarParticle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        radius: 0.8 + _random.nextDouble() * 1.8,
        speed: 0.2 + _random.nextDouble() * 0.8,
        pulseSpeed: 1.0 + _random.nextDouble() * 3.0,
        baseAlpha: 0.2 + _random.nextDouble() * 0.45,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          size: Size.infinite,
          painter: _CosmicSkyBackgroundPainter(
            progress: _controller.value,
            stars: _stars,
          ),
        );
      },
    );
  }
}

class _StarParticle {
  final double x;
  final double y;
  final double radius;
  final double speed;
  final double pulseSpeed;
  final double baseAlpha;

  _StarParticle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.pulseSpeed,
    required this.baseAlpha,
  });
}

class _CosmicSkyBackgroundPainter extends CustomPainter {
  final double progress;
  final List<_StarParticle> stars;

  _CosmicSkyBackgroundPainter({
    required this.progress,
    required this.stars,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // 1. Base Rich Oceanic Midnight Gradient
    final baseGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: const [
        Color(0xFF020713), // Deep oceanic midnight
        Color(0xFF041126), // Sapphire navy
        Color(0xFF061A38), // Rich celestial blue
        Color(0xFF030D1E), // Deep slate blue
        Color(0xFF01050D), // Abyss base
      ],
      stops: const [0.0, 0.25, 0.55, 0.80, 1.0],
    );

    canvas.drawRect(
      rect,
      Paint()..shader = baseGradient.createShader(rect),
    );

    // 2. Animated Floating Aurora Blobs (Sky & Blue Gradients)
    final time = progress * 2 * math.pi;

    // --- Blob 1: Electric Sky Blue (Top-Left / Center Drift) ---
    final blob1X = size.width * (0.25 + 0.18 * math.sin(time * 0.9));
    final blob1Y = size.height * (0.20 + 0.12 * math.cos(time * 0.7));
    final blob1Radius = math.min(size.width, size.height) * 0.48;

    final blob1Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF38BDF8).withOpacity(0.24), // Vibrant Sky Blue
          const Color(0xFF0284C7).withOpacity(0.12), // Ocean Blue
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(blob1X, blob1Y), radius: blob1Radius));

    canvas.drawCircle(Offset(blob1X, blob1Y), blob1Radius, blob1Paint);

    // --- Blob 2: Royal Sapphire Blue (Center-Right Drift) ---
    final blob2X = size.width * (0.75 + 0.15 * math.cos(time * 0.8));
    final blob2Y = size.height * (0.45 + 0.15 * math.sin(time * 1.1));
    final blob2Radius = math.min(size.width, size.height) * 0.55;

    final blob2Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF2563EB).withOpacity(0.22), // Royal Blue
          const Color(0xFF1D4ED8).withOpacity(0.10), // Deep Sapphire
          Colors.transparent,
        ],
        stops: const [0.0, 0.48, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(blob2X, blob2Y), radius: blob2Radius));

    canvas.drawCircle(Offset(blob2X, blob2Y), blob2Radius, blob2Paint);

    // --- Blob 3: Neon Cyan / Aquamarine (Bottom-Left Drift) ---
    final blob3X = size.width * (0.20 + 0.16 * math.cos(time * 0.6));
    final blob3Y = size.height * (0.78 + 0.10 * math.sin(time * 0.9));
    final blob3Radius = math.min(size.width, size.height) * 0.50;

    final blob3Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF06B6D4).withOpacity(0.18), // Electric Cyan
          const Color(0xFF0284C7).withOpacity(0.08),
          Colors.transparent,
        ],
        stops: const [0.0, 0.42, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(blob3X, blob3Y), radius: blob3Radius));

    canvas.drawCircle(Offset(blob3X, blob3Y), blob3Radius, blob3Paint);

    // --- Blob 4: Deep Violet / Indigo Glow (Bottom-Right Depth) ---
    final blob4X = size.width * (0.80 + 0.12 * math.sin(time * 1.0));
    final blob4Y = size.height * (0.82 + 0.10 * math.cos(time * 0.8));
    final blob4Radius = math.min(size.width, size.height) * 0.45;

    final blob4Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF6366F1).withOpacity(0.16), // Indigo
          const Color(0xFF4F46E5).withOpacity(0.06),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(blob4X, blob4Y), radius: blob4Radius));

    canvas.drawCircle(Offset(blob4X, blob4Y), blob4Radius, blob4Paint);

    // 3. Subtle Cyber Mesh Grid (Futuristic developer aesthetic)
    final gridPaint = Paint()
      ..color = const Color(0xFF38BDF8).withOpacity(0.025)
      ..strokeWidth = 1.0;

    const gridSpacing = 56.0;
    for (double x = 0; x < size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 4. Floating Ambient Star Particles
    final starPaint = Paint()..style = PaintingStyle.fill;
    for (final star in stars) {
      // Gentle vertical drift
      final currentY = (star.y - progress * star.speed * 0.25) % 1.0;
      final px = star.x * size.width;
      final py = currentY * size.height;

      // Soft twinkle pulse
      final pulse = (math.sin(time * star.pulseSpeed + star.x * 20) + 1.0) / 2.0;
      final alpha = (star.baseAlpha * (0.5 + 0.5 * pulse)).clamp(0.0, 1.0);

      starPaint.color = const Color(0xFFBAE6FD).withOpacity(alpha); // Soft Ice Sky
      canvas.drawCircle(Offset(px, py), star.radius, starPaint);
    }

    // 5. Ambient Vignette (Keeps content crystal readable)
    final vignettePaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.15,
        colors: [
          Colors.transparent,
          const Color(0xFF010611).withOpacity(0.55),
        ],
        stops: const [0.55, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, vignettePaint);
  }

  @override
  bool shouldRepaint(covariant _CosmicSkyBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
