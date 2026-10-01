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
        "title": "Flutter & Dart Specialist",
        "desc": "Deep mastery of Flutter engine, reactive state, custom animations, and responsive UIs.",
        "icon": Icons.flutter_dash,
        "color": AppColors.secondaryAccent,
      },
      {
        "title": "Dual-Platform Android & iOS",
        "desc": "Seamless native deployment across Play Store & App Store Connect with high ratings.",
        "icon": Icons.apple_rounded,
        "color": AppColors.primaryAccent,
      },
      {
        "title": "Clean Architecture & MVVM",
        "desc": "Enterprise code structures using SOLID principles, separation of concerns, and clean testing.",
        "icon": Icons.layers_rounded,
        "color": AppColors.violetAccent,
      },
      {
        "title": "100K+ Production Reach",
        "desc": "Proven track record delivering 15+ live applications trusted by over 100,000 active users.",
        "icon": Icons.groups_rounded,
        "color": AppColors.greenAccent,
      },
      {
        "title": "Payment & Backend Integrations",
        "desc": "Razorpay, Stripe, CCAvenue, Mollie, Firebase Auth/Firestore, and Supabase integrations.",
        "icon": Icons.payments_rounded,
        "color": AppColors.orangeAccent,
      },
      {
        "title": "Team Leadership & Mentoring",
        "desc": "Leading sprint planning, architectural design reviews, client syncs, and mentoring engineers.",
        "icon": Icons.verified_user_rounded,
        "color": AppColors.secondaryAccent,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 115,
      ),
      itemCount: highlights.length,
      itemBuilder: (context, idx) {
        final item = highlights[idx];
        final col = item["color"] as Color;
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: col.withOpacity(0.04),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: col.withOpacity(0.18), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: col.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: col,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["title"] as String,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        item["desc"] as String,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          height: 1.35,
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
    ).animate(target: _animate ? 1 : 0).fadeIn(delay: 350.ms, duration: 600.ms);
  }

  Widget _buildStatsGrid(TextTheme textTheme) {
    final size = MediaQuery.of(context).size;
    final statColors = [
      AppColors.secondaryAccent,
      AppColors.primaryAccent,
      AppColors.greenAccent,
      AppColors.orangeAccent,
    ];
    final statIcons = [
      Icons.work_history_rounded,
      Icons.rocket_launch_rounded,
      Icons.trending_up_rounded,
      Icons.sentiment_very_satisfied_rounded,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (size.width >= 900) ...[
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.secondaryAccent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Key Metrics & Milestones",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: AppStrings.statsData.length,
          itemBuilder: (context, index) {
            final stat = AppStrings.statsData[index];
            final rawValue = stat["value"] as String;
            final label = stat["label"] as String;
            final col = statColors[index % statColors.length];
            final icon = statIcons[index % statIcons.length];

            final numericStr = RegExp(r'\d+').stringMatch(rawValue) ?? "0";
            final targetVal = int.parse(numericStr);
            final suffix = rawValue.replaceAll(numericStr, "");

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GlassCard(
                glowColor: col,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                hasHoverEffect: true,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: col.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: col, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        label,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    AnimatedCounter(
                      targetValue: targetVal,
                      suffix: suffix,
                      style: textTheme.displaySmall!.copyWith(
                        color: col,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
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
