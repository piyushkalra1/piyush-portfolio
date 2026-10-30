import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/widgets/glass_card.dart';

class SkillsSection extends StatefulWidget {
  final ValueChanged<double> onVisible;
  const SkillsSection({super.key, required this.onVisible});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _animate = false;

  void _triggerAnimations() {
    if (!_animate) {
      setState(() {
        _animate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;
    final categories = AppStrings.skillsData.keys.toList();

    return VisibilityDetector(
      key: const Key('skills_section'),
      onVisibilityChanged: (info) {
        widget.onVisible(info.visibleFraction);
        if (info.visibleFraction > 0.15) {
          _triggerAnimations();
        }
      },
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          // Rich modern space mesh gradient
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF030508), // deep space black
              Color(0xFF070C1A), // midnight indigo
              Color(0xFF050812), // deep slate
              Color(0xFF080616), // subtle dark violet
              Color(0xFF020305), // smooth base
            ],
            stops: [0.0, 0.28, 0.55, 0.82, 1.0],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Ambient Glowing Orbs
            // Orb 1: Top Right (Indigo / Cyan glow)
            Positioned(
              top: -120,
              right: -100,
              child: Container(
                width: math.min(size.width * 0.7, 650),
                height: math.min(size.width * 0.7, 650),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryAccent.withOpacity(0.18),
                      AppColors.violetAccent.withOpacity(0.06),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),

            // Orb 2: Center Left (Cyan / Emerald glow)
            Positioned(
              top: 380,
              left: -140,
              child: Container(
                width: math.min(size.width * 0.65, 550),
                height: math.min(size.width * 0.65, 550),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.secondaryAccent.withOpacity(0.15),
                      AppColors.greenAccent.withOpacity(0.04),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.42, 1.0],
                  ),
                ),
              ),
            ),

            // Orb 3: Bottom Right (Violet / Pink Glow)
            Positioned(
              bottom: -120,
              right: -80,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.violetAccent.withOpacity(0.14),
                      AppColors.pinkAccent.withOpacity(0.04),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),

            // Subtle Background Grid Mesh Overlay
            Positioned.fill(
              child: CustomPaint(
                painter: _CyberGridPainter(),
              ),
            ),

            // Main Content Container
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      _buildSectionHeader(textTheme),
                      const SizedBox(height: 28),

                      // Tech Highlight Ribbon (Enterprise & IoT Banner)
                      _buildHighlightRibbon(),
                      const SizedBox(height: 50),

                      // Modern Skills Category Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isCompact ? 1 : (size.width < 1200 ? 2 : 3),
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          mainAxisExtent: 380,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, catIdx) {
                          final category = categories[catIdx];
                          final skills = AppStrings.skillsData[category] ?? [];
                          final color = _getCategoryColor(catIdx);

                          return GlassCard(
                            glowColor: color,
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category Header
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                color.withOpacity(0.25),
                                                color.withOpacity(0.08),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: color.withOpacity(0.35), width: 1.2),
                                          ),
                                          child: Icon(
                                            _getCategoryIcon(category),
                                            color: color,
                                            size: 22,
                                          ),
                                        ),
                                        const SizedBox(width: 14),
                                        Text(
                                          category,
                                          style: textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: color.withOpacity(0.25)),
                                      ),
                                      child: Text(
                                        "${skills.length} Tools",
                                        style: TextStyle(
                                          color: color,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                Divider(color: color.withOpacity(0.18), height: 1),
                                const SizedBox(height: 16),

                                // Modern Skill Cards (No percentage bars)
                                Expanded(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: skills.length,
                                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                                    itemBuilder: (context, skillIdx) {
                                      final skill = skills[skillIdx];
                                      final name = skill["name"] as String;
                                      final tag = (skill["tag"] as String?) ?? "Production Ready";
                                      final iconName = (skill["icon"] as String?) ?? "code";

                                      return _ModernSkillTile(
                                        name: name,
                                        tag: tag,
                                        iconName: iconName,
                                        accentColor: color,
                                        textTheme: textTheme,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ).animate(target: _animate ? 1 : 0).fadeIn(delay: 200.ms, duration: 600.ms),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "PRODUCTION TECH STACK",
              style: textTheme.labelLarge?.copyWith(
                color: AppColors.primaryAccent,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.secondaryAccent.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.secondaryAccent.withOpacity(0.3)),
              ),
              child: const Text(
                "Modern Architecture",
                style: TextStyle(
                  color: AppColors.secondaryAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "Expertise & Technical Stack",
          style: textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Battle-tested technologies, architectural patterns, and IoT hardware protocols powering 15+ high-performance applications.",
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.primaryAccent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    ).animate(target: _animate ? 1 : 0).fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildHighlightRibbon() {
    final highlights = [
      {"icon": Icons.flutter_dash_rounded, "label": "Flutter 3.x Lead", "color": AppColors.secondaryAccent},
      {"icon": Icons.architecture_rounded, "label": "Clean Architecture & BLoC", "color": AppColors.primaryAccent},
      {"icon": Icons.nfc_rounded, "label": "Hardware IoT (NFC & RFID)", "color": AppColors.violetAccent},
      {"icon": Icons.lock_outline_rounded, "label": "Child Safety Kiosk Mode", "color": AppColors.greenAccent},
      {"icon": Icons.payments_rounded, "label": "StoreKit & In-App Subscriptions", "color": const Color(0xFFF59E0B)},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: highlights.map((h) {
          final color = h["color"] as Color;
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(0.28), width: 1.1),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.12),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(h["icon"] as IconData, size: 15, color: color),
                const SizedBox(width: 8),
                Text(
                  h["label"] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ).animate(target: _animate ? 1 : 0).fadeIn(delay: 150.ms, duration: 500.ms);
  }

  Color _getCategoryColor(int index) {
    final colors = [
      AppColors.primaryAccent,   // Indigo
      AppColors.secondaryAccent, // Cyan
      AppColors.violetAccent,    // Violet
      AppColors.greenAccent,     // Emerald
      const Color(0xFFF59E0B),   // Amber
      AppColors.pinkAccent,      // Pink
    ];
    return colors[index % colors.length];
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Languages":
        return Icons.code_rounded;
      case "Frameworks & SDKs":
        return Icons.flutter_dash_rounded;
      case "Backend & Cloud Services":
        return Icons.cloud_done_rounded;
      case "State Management":
        return Icons.account_tree_rounded;
      case "Architecture & Security":
        return Icons.layers_rounded;
      case "Payments, Subscriptions & Release":
        return Icons.payments_rounded;
      default:
        return Icons.auto_awesome_rounded;
    }
  }
}

// Interactive Modern Skill Tile (No arbitrary percentages, pure professional polish)
class _ModernSkillTile extends StatefulWidget {
  final String name;
  final String tag;
  final String iconName;
  final Color accentColor;
  final TextTheme textTheme;

  const _ModernSkillTile({
    required this.name,
    required this.tag,
    required this.iconName,
    required this.accentColor,
    required this.textTheme,
  });

  @override
  State<_ModernSkillTile> createState() => _ModernSkillTileState();
}

class _ModernSkillTileState extends State<_ModernSkillTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.accentColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered 
              ? color.withOpacity(0.12)
              : AppColors.surfaceCard.withOpacity(0.55),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isHovered 
                ? color.withOpacity(0.5) 
                : AppColors.borderLight.withOpacity(0.6),
            width: 1,
          ),
          boxShadow: _isHovered ? [
            BoxShadow(
              color: color.withOpacity(0.18),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ] : null,
        ),
        child: Row(
          children: [
            // Micro Icon
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.14),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                _getSkillIcon(widget.iconName),
                size: 15,
                color: color,
              ),
            ),
            const SizedBox(width: 10),

            // Skill Name
            Expanded(
              child: Text(
                widget.name,
                style: widget.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: _isHovered ? Colors.white : AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),

            // Professional Badge Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _isHovered 
                    ? color.withOpacity(0.22)
                    : color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isHovered ? color.withOpacity(0.5) : color.withOpacity(0.2),
                  width: 0.8,
                ),
              ),
              child: Text(
                widget.tag,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getSkillIcon(String iconName) {
    switch (iconName) {
      case "code":
        return Icons.code_rounded;
      case "android":
        return Icons.android_rounded;
      case "apple":
        return Icons.apple_rounded;
      case "terminal":
        return Icons.terminal_rounded;
      case "flutter":
        return Icons.flutter_dash_rounded;
      case "nfc":
        return Icons.nfc_rounded;
      case "sync":
        return Icons.sync_alt_rounded;
      case "map":
        return Icons.map_rounded;
      case "video":
        return Icons.video_call_rounded;
      case "fire":
        return Icons.local_fire_department_rounded;
      case "notifications":
        return Icons.notifications_active_rounded;
      case "database":
        return Icons.storage_rounded;
      case "speed":
        return Icons.speed_rounded;
      case "tree":
        return Icons.account_tree_rounded;
      case "layers":
        return Icons.layers_rounded;
      case "bolt":
        return Icons.bolt_rounded;
      case "waves":
        return Icons.waves_rounded;
      case "architecture":
        return Icons.architecture_rounded;
      case "shield":
        return Icons.security_rounded;
      case "lock":
        return Icons.lock_outline_rounded;
      case "security":
        return Icons.vpn_key_rounded;
      case "payments":
        return Icons.payments_rounded;
      case "credit_card":
        return Icons.credit_card_rounded;
      case "play_arrow":
        return Icons.play_arrow_rounded;
      case "app_store":
        return Icons.verified_rounded;
      default:
        return Icons.auto_awesome_rounded;
    }
  }
}

// Background Cyber Grid Painter for High-Tech Aesthetic
class _CyberGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(0.025)
      ..strokeWidth = 1.0;

    const step = 48.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
