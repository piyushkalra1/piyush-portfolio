import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/widgets/glass_card.dart';

class AchievementsSection extends StatefulWidget {
  final ValueChanged<double> onVisible;
  const AchievementsSection({super.key, required this.onVisible});

  @override
  State<AchievementsSection> createState() => _AchievementsSectionState();
}

class _AchievementsSectionState extends State<AchievementsSection> {
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;
    final achievements = AppStrings.achievementsList;

    return VisibilityDetector(
      key: const Key('achievements_section'),
      onVisibilityChanged: (info) {
        widget.onVisible(info.visibleFraction);
        if (info.visibleFraction > 0.15 && !_animate) {
          setState(() {
            _animate = true;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        width: double.infinity,
        color: AppColors.surface,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                _buildSectionHeader(textTheme),
                const SizedBox(height: 60),

                // Grid of achievements
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isCompact ? 1 : 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    mainAxisExtent: 180,
                  ),
                  itemCount: achievements.length,
                  itemBuilder: (context, index) {
                    final ach = achievements[index];
                    final title = ach["title"] as String;
                    final desc = ach["description"] as String;
                    final source = ach["source"] as String;
                    final color = _getAchievementColor(index);

                    return GlassCard(
                      glowColor: color,
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Trophy icon / Ribbon icon
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.emoji_events_outlined,
                              color: color,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 20),
                          
                          // Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  source,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: Text(
                                    desc,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
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
          "ACHIEVEMENTS",
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.primaryAccent,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Milestones & Badges",
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

  Color _getAchievementColor(int index) {
    final colors = [
      Colors.amber,              // Gold
      AppColors.primaryAccent,   // Indigo
      AppColors.secondaryAccent, // Cyan
      AppColors.greenAccent,     // Green
    ];
    return colors[index % colors.length];
  }
}
