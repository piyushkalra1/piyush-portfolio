import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/widgets/glass_card.dart';
import 'package:portfolio/widgets/animated_counter.dart';

class AboutSection extends StatefulWidget {
  final ValueChanged<double> onVisible;
  const AboutSection({super.key, required this.onVisible});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;

    return VisibilityDetector(
      key: const Key('about_section'),
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

                // Main Layout
                if (isCompact)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBioText(textTheme),
                      const SizedBox(height: 48),
                      _buildStatsGrid(textTheme),
                      const SizedBox(height: 48),
                      _buildHighlightsGrid(textTheme),
                    ],
                  )
                else

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBioText(textTheme),
                            const SizedBox(height: 48),
                            _buildHighlightsGrid(textTheme),
                          ],
                        ),
                      ),
                      const SizedBox(width: 60),
                      Expanded(
                        flex: 4,
                        child: _buildStatsGrid(textTheme),
                      ),
                    ],
                  ),
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
          "ABOUT ME",
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.primaryAccent,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Professional Bio",
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

  Widget _buildBioText(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Who I Am",
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.devAboutLong,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.7,
          ),
        ),
      ],
    ).animate(target: _animate ? 1 : 0).fadeIn(delay: 200.ms, duration: 500.ms);
  }

  Widget _buildHighlightsGrid(TextTheme textTheme) {
    final highlights = [
      {
        "title": "Flutter Expert",
        "desc": "Deep knowledge of Flutter frameworks, layouts, and engine lifecycle.",
        "icon": Icons.star_border,
      },
      {
        "title": "Cross Platform",
        "desc": "Write code once that compiles perfectly to Android, iOS, and Web platforms.",
        "icon": Icons.devices,
      },
      {
        "title": "Native Integration",
        "desc": "Experienced in building native bridges (Swift, Kotlin) and custom platform channels.",
        "icon": Icons.extension,
      },
      {
        "title": "Performance Tuning",
        "desc": "Optimize rendering pipelines, memory usage, and loading states.",
        "icon": Icons.speed,
      },
      {
        "title": "Beautiful UI",
        "desc": "Translate complex designs into responsive pixel-perfect layouts.",
        "icon": Icons.palette_outlined,
      },
      {
        "title": "Clean Architecture",
        "desc": "Scale projects using MVVM patterns and modular structure.",
        "icon": Icons.layers_outlined,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 110,
      ),
      itemCount: highlights.length,
      itemBuilder: (context, idx) {
        final item = highlights[idx];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryAccent.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item["icon"] as IconData,
                color: AppColors.primaryAccent,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"] as String,
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      item["desc"] as String,
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
        );
      },
    ).animate(target: _animate ? 1 : 0).fadeIn(delay: 350.ms, duration: 600.ms);
  }

  Widget _buildStatsGrid(TextTheme textTheme) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (size.width >= 900) ...[
          Text(
            "Metrics",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
        ],
        // Build cards for stats
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: AppStrings.statsData.length,
          itemBuilder: (context, index) {
            final stat = AppStrings.statsData[index];
            final rawValue = stat["value"] as String;
            final label = stat["label"] as String;

            // Extract numeric part for counter
            final numericStr = RegExp(r'\d+').stringMatch(rawValue) ?? "0";
            final targetVal = int.parse(numericStr);
            final suffix = rawValue.replaceAll(numericStr, "");

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GlassCard(
                padding: const EdgeInsets.all(20),
                hasHoverEffect: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    AnimatedCounter(
                      targetValue: targetVal,
                      suffix: suffix,
                      style: textTheme.displaySmall!.copyWith(
                        color: AppColors.secondaryAccent,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ).animate(target: _animate ? 1 : 0).fadeIn(delay: 250.ms, duration: 500.ms);
  }
}
