import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';

class HeroSection extends StatefulWidget {
  final ValueChanged<double> onVisible;
  final ValueChanged<String> onActionPressed;

  const HeroSection({
    super.key,
    required this.onVisible,
    required this.onActionPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _particleController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await launchUrl(uri)) {
      // url launched
    }
  }

  Future<void> _downloadResume() async {
    const url = 'assets/assets/resume/Piyush_Kalra_Resume.pdf';
    final uri = Uri.parse(url);
    if (await launchUrl(uri)) {
      // PDF opened
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;

    return VisibilityDetector(
      key: const Key('hero_section'),
      onVisibilityChanged: (info) => widget.onVisible(info.visibleFraction),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: math.max(650, size.height - 70),
        ),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Glows & Particles
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _particleController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _BackgroundParticlePainter(
                      progress: _particleController.value,
                    ),
                  );
                },
              ),
            ),

            // Top radial soft gradient blob
            Positioned(
              top: -size.height * 0.15,
              right: -size.width * 0.1,
              child: Container(
                width: math.min(size.width * 0.6, 600),
                height: math.min(size.width * 0.6, 600),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryAccent.withOpacity(0.15),
                      AppColors.secondaryAccent.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Bottom left subtle glow
            Positioned(
              bottom: -100,
              left: -100,
              child: Container(
                width: 450,
                height: 450,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.violetAccent.withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Main Hero Grid / Row
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isCompact ? 24 : 48,
                vertical: isCompact ? 60 : 40,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: isCompact
                      ? _buildCompactLayout(context, textTheme)
                      : _buildWideLayout(context, textTheme),
                ),
              ),
            ),

            // Scroll indicator at bottom (Wide screens only)
            if (!isCompact)
              Positioned(
                bottom: 24,
                child: Column(
                  children: [
                    Text(
                      "EXPLORE",
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                        letterSpacing: 2.5,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary,
                      size: 22,
                    )
                        .animate(onPlay: (controller) => controller.repeat())
                        .slideY(begin: -0.25, end: 0.25, duration: 1100.ms, curve: Curves.easeInOut)
                        .fadeIn(duration: 500.ms)
                        .then()
                        .fadeOut(duration: 500.ms),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column (Text & CTAs)
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAvailabilityBadge(),
              const SizedBox(height: 20),
              _buildHeadline(textTheme),
              const SizedBox(height: 14),
              _buildTypingAnimator(textTheme),
              const SizedBox(height: 20),
              _buildIntroText(textTheme),
              const SizedBox(height: 24),
              _buildHighlightMetricsRow(),
              const SizedBox(height: 32),
              _buildButtonsRow(),
              const SizedBox(height: 36),
              _buildSocialsRow(),
            ],
          ),
        ),

        const SizedBox(width: 48),

        // Right Column (Profile Picture)
        Expanded(
          flex: 4,
          child: _buildProfileImage(320),
        ),
      ],
    );
  }

  Widget _buildCompactLayout(BuildContext context, TextTheme textTheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileImage(210),
        const SizedBox(height: 32),
        _buildAvailabilityBadge(),
        const SizedBox(height: 16),
        _buildHeadline(textTheme, center: true),
        const SizedBox(height: 12),
        _buildTypingAnimator(textTheme, center: true),
        const SizedBox(height: 18),
        _buildIntroText(textTheme, center: true),
        const SizedBox(height: 22),
        _buildHighlightMetricsRow(center: true),
        const SizedBox(height: 28),
        _buildButtonsRow(center: true),
        const SizedBox(height: 28),
        _buildSocialsRow(center: true),
      ],
    );
  }

  Widget _buildAvailabilityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0x1A10B981), // Translucent green
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0x5510B981), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.greenAccent.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.greenAccent,
              shape: BoxShape.circle,
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(begin: const Offset(0.85, 0.85), end: const Offset(1.25, 1.25), duration: 1.seconds),
          const SizedBox(width: 9),
          const Text(
            "AVAILABLE FOR WORK & PROJECTS",
            style: TextStyle(
              color: AppColors.greenAccent,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w700,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0);
  }

  Widget _buildHeadline(TextTheme textTheme, {bool center = false}) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white, Color(0xFFE2E8F0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        AppStrings.devName,
        textAlign: center ? TextAlign.center : TextAlign.left,
        style: textTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.w900,
          height: 1.05,
          letterSpacing: -1.5,
          fontSize: center ? 42 : 56,
        ),
      ),
    ).animate().fadeIn(delay: 150.ms, duration: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTypingAnimator(TextTheme textTheme, {bool center = false}) {
    final textStyle = textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: center ? 20 : 26,
      color: AppColors.primaryAccent,
    );

    return SizedBox(
      height: 38,
      child: Row(
        mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(
            "I build ",
            style: textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: center ? 20 : 26,
            ),
          ),
          AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TypewriterAnimatedText("Production Flutter Apps", textStyle: textStyle, speed: 80.ms),
              TypewriterAnimatedText("Android & iOS Applications", textStyle: textStyle, speed: 80.ms),
              TypewriterAnimatedText("Scalable Clean Architecture", textStyle: textStyle, speed: 80.ms),
              TypewriterAnimatedText("High-Performance Mobile UIs", textStyle: textStyle, speed: 80.ms),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 500.ms);
  }

  Widget _buildIntroText(TextTheme textTheme, {bool center = false}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 580),
      child: Text(
        AppStrings.devAboutShort,
        textAlign: center ? TextAlign.center : TextAlign.left,
        style: textTheme.bodyLarge?.copyWith(
          color: AppColors.textSecondary,
          height: 1.6,
          fontSize: 15.5,
        ),
      ),
    ).animate().fadeIn(delay: 450.ms, duration: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildHighlightMetricsRow({bool center = false}) {
    final metrics = [
      {"icon": Icons.verified_rounded, "label": "4+ Years Exp", "color": AppColors.secondaryAccent},
      {"icon": Icons.rocket_launch_rounded, "label": "15+ Apps Shipped", "color": AppColors.primaryAccent},
      {"icon": Icons.trending_up_rounded, "label": "100K+ Downloads", "color": AppColors.greenAccent},
    ];

    return Wrap(
      alignment: center ? WrapAlignment.center : WrapAlignment.start,
      spacing: 12,
      runSpacing: 10,
      children: metrics.map((m) {
        final col = m["color"] as Color;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: col.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: col.withOpacity(0.25), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(m["icon"] as IconData, size: 14, color: col),
              const SizedBox(width: 7),
              Text(
                m["label"] as String,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ).animate().fadeIn(delay: 500.ms, duration: 500.ms);
  }

  Widget _buildButtonsRow({bool center = false}) {
    return Wrap(
      alignment: center ? WrapAlignment.center : WrapAlignment.start,
      spacing: 16,
      runSpacing: 14,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryAccent, Color(0xFF4F46E5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryAccent.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => widget.onActionPressed("Projects"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Explore Work",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, size: 18),
              ],
            ),
          ),
        ),
        OutlinedButton(
          onPressed: _downloadResume,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Color(0x33FFFFFF), width: 1.3),
            backgroundColor: const Color(0x0FFFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.download_rounded, size: 18, color: AppColors.secondaryAccent),
              SizedBox(width: 8),
              Text(
                "Download Resume",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms, duration: 500.ms);
  }

  Widget _buildSocialsRow({bool center = false}) {
    return Row(
      mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        _buildSocialIcon(Icons.work_outline_rounded, AppStrings.linkedinUrl, "LinkedIn"),
        const SizedBox(width: 14),
        _buildSocialIcon(Icons.email_outlined, "mailto:${AppStrings.emailAddress}", "Email"),
        const SizedBox(width: 14),
        _buildSocialIcon(Icons.phone_outlined, "tel:${AppStrings.phoneNumber.replaceAll(' ', '')}", "Phone"),
      ],
    ).animate().fadeIn(delay: 750.ms, duration: 500.ms);
  }

  Widget _buildSocialIcon(IconData icon, String url, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderLight, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.textSecondary, size: 19),
        ),
      ),
    );
  }

  Widget _buildProfileImage(double imageSize) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Animated outer glowing rings
          Container(
            height: imageSize + 28,
            width: imageSize + 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryAccent.withOpacity(0.2),
                width: 1.5,
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(begin: const Offset(1, 1), end: const Offset(1.08, 1.08), duration: 2.5.seconds, curve: Curves.easeInOut)
              .fadeOut(duration: 2.5.seconds),

          // Gradient spinning halo
          Container(
            height: imageSize + 12,
            width: imageSize + 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  AppColors.primaryAccent.withOpacity(0.0),
                  AppColors.primaryAccent,
                  AppColors.secondaryAccent,
                  AppColors.violetAccent,
                  AppColors.primaryAccent.withOpacity(0.0),
                ],
                stops: const [0.0, 0.35, 0.65, 0.85, 1.0],
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .rotate(duration: 6.seconds, curve: Curves.linear),

          // Profile Image Mask
          Container(
            height: imageSize,
            width: imageSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surfaceCard,
                  child: const Icon(
                    Icons.person,
                    size: 80,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),

          // Floating Experience Badge on Avatar
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xF009090B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryAccent.withOpacity(0.6), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryAccent.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.workspace_premium_rounded, color: Color(0xFFFBBF24), size: 16),
                  SizedBox(width: 5),
                  Text(
                    "4+ Years",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, curve: Curves.easeOutCubic).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }
}

class _BackgroundParticlePainter extends CustomPainter {
  final double progress;
  _BackgroundParticlePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final paint = Paint()
      ..color = AppColors.primaryAccent.withOpacity(0.035)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      final double baseSpeed = 20 + random.nextInt(40).toDouble();
      final double baseRadius = 5 + random.nextInt(15).toDouble();
      final double startX = random.nextDouble() * size.width;
      final double startY = random.nextDouble() * size.height;

      final double offsetY = -baseSpeed * progress;
      double currentY = startY + offsetY;
      if (currentY < 0) {
        currentY = size.height + (currentY % size.height);
      }

      final double currentX = startX + 15 * math.sin(progress * 2 * math.pi + i);

      canvas.drawCircle(Offset(currentX, currentY), baseRadius, paint);
    }
  }

  @override
  bool shouldRepaint(_BackgroundParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
