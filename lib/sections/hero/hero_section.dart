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
    // Continuous loop for floating background particles
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;

    return VisibilityDetector(
      key: const Key('hero_section'),
      onVisibilityChanged: (info) => widget.onVisible(info.visibleFraction),
      child: Container(
        height: size.height - 70, // subtract navbar height
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 600),
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
              top: -size.height * 0.2,
              right: -size.width * 0.1,
              child: Container(
                width: size.width * 0.5,
                height: size.width * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryAccent.withOpacity(0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Main Hero Grid / Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: isCompact 
                    ? _buildCompactLayout(context, textTheme)
                    : _buildWideLayout(context, textTheme),
                ),
              ),
            ),

            // Scroll indicator at bottom
            Positioned(
              bottom: 30,
              child: Column(
                children: [
                  Text(
                    "SCROLL DOWN",
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .slideY(begin: -0.2, end: 0.2, duration: 1000.ms, curve: Curves.easeInOut)
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
              _buildGreeting(textTheme),
              const SizedBox(height: 16),
              _buildHeadline(textTheme),
              const SizedBox(height: 16),
              _buildTypingAnimator(textTheme),
              const SizedBox(height: 24),
              _buildIntroText(textTheme),
              const SizedBox(height: 32),
              _buildButtonsRow(),
              const SizedBox(height: 40),
              _buildSocialsRow(),
            ],
          ),
        ),

        const SizedBox(width: 40),

        // Right Column (Profile Picture)
        Expanded(
          flex: 4,
          child: _buildProfileImage(320),
        ),
      ],
    );
  }

  Widget _buildCompactLayout(BuildContext context, TextTheme textTheme) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileImage(220),
          const SizedBox(height: 32),
          _buildGreeting(textTheme, center: true),
          const SizedBox(height: 12),
          _buildHeadline(textTheme, center: true),
          const SizedBox(height: 12),
          _buildTypingAnimator(textTheme, center: true),
          const SizedBox(height: 16),
          _buildIntroText(textTheme, center: true),
          const SizedBox(height: 24),
          _buildButtonsRow(center: true),
          const SizedBox(height: 32),
          _buildSocialsRow(center: true),
        ],
      ),
    );
  }

  Widget _buildGreeting(TextTheme textTheme, {bool center = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryAccent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryAccent.withOpacity(0.2), width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bolt, color: AppColors.secondaryAccent, size: 16),
          const SizedBox(width: 6),
          Text(
            "WELCOME TO MY PORTFOLIO",
            style: textTheme.labelLarge?.copyWith(
              color: AppColors.secondaryAccent,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0);
  }

  Widget _buildHeadline(TextTheme textTheme, {bool center = false}) {
    return Text(
      AppStrings.devName,
      textAlign: center ? TextAlign.center : TextAlign.left,
      style: textTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.w900,
        height: 1.0,
      ),
    ).animate().fadeIn(delay: 150.ms, duration: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTypingAnimator(TextTheme textTheme, {bool center = false}) {
    final textStyle = textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: AppColors.primaryAccent,
    );

    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text("I'm a ", style: textTheme.headlineMedium?.copyWith(color: AppColors.textPrimary)),
          AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TypewriterAnimatedText("Flutter Developer", textStyle: textStyle, speed: 100.ms),
              TypewriterAnimatedText("iOS Developer", textStyle: textStyle, speed: 100.ms),
              TypewriterAnimatedText("Android Developer", textStyle: textStyle, speed: 100.ms),
              TypewriterAnimatedText("Firebase Expert", textStyle: textStyle, speed: 100.ms),
              TypewriterAnimatedText("Cross-Platform Dev", textStyle: textStyle, speed: 100.ms),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 500.ms);
  }

  Widget _buildIntroText(TextTheme textTheme, {bool center = false}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 550),
      child: Text(
        AppStrings.devAboutShort,
        textAlign: center ? TextAlign.center : TextAlign.left,
        style: textTheme.bodyLarge?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    ).animate().fadeIn(delay: 450.ms, duration: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildButtonsRow({bool center = false}) {
    return Wrap(
      alignment: center ? WrapAlignment.center : WrapAlignment.start,
      spacing: 16,
      runSpacing: 16,
      children: [
        ElevatedButton(
          onPressed: () => widget.onActionPressed("Projects"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("View Projects"),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () => widget.onActionPressed("Resume"),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          ),
          child: const Text("Download Resume"),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms, duration: 500.ms);
  }

  Widget _buildSocialsRow({bool center = false}) {
    return Row(
      mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        _buildSocialIcon(Icons.code, AppStrings.githubUrl, "GitHub"),
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.work_outline, AppStrings.linkedinUrl, "LinkedIn"),
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.email_outlined, "mailto:${AppStrings.emailAddress}", "Email"),
        const SizedBox(width: 16),
        _buildSocialIcon(Icons.phone_outlined, "tel:${AppStrings.phoneNumber.replaceAll(' ', '')}", "Phone"),
      ],
    ).animate().fadeIn(delay: 750.ms, duration: 500.ms);
  }

  Widget _buildSocialIcon(IconData icon, String url, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderLight, width: 1),
        ),
        child: IconButton(
          icon: Icon(icon, color: AppColors.textSecondary, size: 20),
          onPressed: () => _launchUrl(url),
          hoverColor: AppColors.primaryAccent.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget _buildProfileImage(double imageSize) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated outer glowing rings
          Container(
            height: imageSize + 24,
            width: imageSize + 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryAccent.withOpacity(0.2),
                width: 1,
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(begin: const Offset(1, 1), end: const Offset(1.08, 1.08), duration: 2.seconds, curve: Curves.easeInOut)
              .fadeOut(duration: 2.seconds),
          
          Container(
            height: imageSize + 10,
            width: imageSize + 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  AppColors.primaryAccent.withOpacity(0.0),
                  AppColors.primaryAccent,
                  AppColors.secondaryAccent,
                  AppColors.primaryAccent.withOpacity(0.0),
                ],
                stops: const [0.0, 0.4, 0.6, 1.0],
              ),
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .rotate(duration: 4.seconds, curve: Curves.linear),

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
    final random = math.Random(42); // Seeded random for consistency
    final paint = Paint()
      ..color = AppColors.primaryAccent.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 20; i++) {
      // Calculate float positioning
      final double baseSpeed = 20 + random.nextInt(40).toDouble();
      final double baseRadius = 5 + random.nextInt(15).toDouble();
      final double startX = random.nextDouble() * size.width;
      final double startY = random.nextDouble() * size.height;
      
      // Floating offset over time
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
