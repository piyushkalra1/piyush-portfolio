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

class _SkillsSectionState extends State<SkillsSection> with SingleTickerProviderStateMixin {
  bool _animate = false;
  late AnimationController _barController;

  @override
  void initState() {
    super.initState();
    _barController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _barController.dispose();
    super.dispose();
  }

  void _triggerAnimations() {
    if (!_animate) {
      setState(() {
        _animate = true;
      });
      _barController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;
    
    // Distribute skills across layout columns
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
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        width: double.infinity,
        color: AppColors.background,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                _buildSectionHeader(textTheme),
                const SizedBox(height: 60),

                // Skills grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isCompact ? 1 : (size.width < 1200 ? 2 : 3),
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    mainAxisExtent: 320,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, catIdx) {
                    final category = categories[catIdx];
                    final skills = AppStrings.skillsData[category] ?? [];

                    return GlassCard(
                      glowColor: _getCategoryColor(catIdx),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Header
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(catIdx).withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  _getCategoryIcon(category),
                                  color: _getCategoryColor(catIdx),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                category,
                                style: textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Skills list with animated progress bar
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: skills.length,
                              itemBuilder: (context, skillIdx) {
                                final skill = skills[skillIdx];
                                final name = skill["name"] as String;
                                final level = skill["level"] as double;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            name,
                                            style: textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          Text(
                                            "${(level * 100).toInt()}%",
                                            style: textTheme.bodySmall?.copyWith(
                                              color: AppColors.textSecondary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      // Custom Animated Progress Bar
                                      Stack(
                                        children: [
                                          Container(
                                            height: 6,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppColors.borderLight,
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                          ),
                                          AnimatedBuilder(
                                            animation: _barController,
                                            builder: (context, child) {
                                              return FractionallySizedBox(
                                                widthFactor: level * _barController.value,
                                                child: Container(
                                                  height: 6,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        _getCategoryColor(catIdx),
                                                        _getCategoryColor(catIdx).withOpacity(0.6),
                                                      ],
                                                    ),
                                                    borderRadius: BorderRadius.circular(3),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: _getCategoryColor(catIdx).withOpacity(0.3),
                                                        blurRadius: 4,
                                                        offset: const Offset(0, 1),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
    );
  }

  Widget _buildSectionHeader(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "MY SKILLS",
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.primaryAccent,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Expertise & Stack",
          style: textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
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

  Color _getCategoryColor(int index) {
    final colors = [
      AppColors.primaryAccent,   // indigo
      AppColors.secondaryAccent, // cyan
      AppColors.violetAccent,    // violet
      AppColors.greenAccent,     // green
      AppColors.pinkAccent,      // pink
      AppColors.orangeAccent,    // orange
    ];
    return colors[index % colors.length];
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Languages":
        return Icons.translate_outlined;
      case "Frameworks & Core":
        return Icons.construction_outlined;
      case "Backend & Services":
        return Icons.cloud_queue_outlined;
      case "State Management":
        return Icons.account_tree_outlined;
      case "Architecture & Database":
        return Icons.storage_outlined;
      case "Tools & Platforms":
        return Icons.grid_view_outlined;
      default:
        return Icons.star_border;
    }
  }
}
