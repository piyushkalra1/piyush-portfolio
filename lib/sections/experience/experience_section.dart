import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/widgets/glass_card.dart';

class ExperienceSection extends StatefulWidget {
  final ValueChanged<double> onVisible;
  const ExperienceSection({super.key, required this.onVisible});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;
    final expList = AppStrings.experienceList;

    return VisibilityDetector(
      key: const Key('experience_section'),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Title
                  _buildSectionHeader(textTheme),
                  const SizedBox(height: 60),

                  // Timeline List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: expList.length,
                    itemBuilder: (context, index) {
                      final exp = expList[index];
                      final role = exp["role"] as String;
                      final company = exp["company"] as String;
                      final location = exp["location"] as String;
                      final duration = exp["duration"] as String;
                      final description = exp["description"] as String;
                      final responsibilities = exp["responsibilities"] as List<String>;

                      return isCompact
                          ? _buildCompactTimelineItem(index, role, company, location, duration, description, responsibilities, textTheme)
                          : _buildWideTimelineItem(index, role, company, location, duration, description, responsibilities, textTheme, expList.length);
                    },
                  ).animate(target: _animate ? 1 : 0).fadeIn(delay: 200.ms, duration: 600.ms),
                ],
              ),
            )
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
          "MY EXPERIENCE",
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.primaryAccent,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Work History",
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

  // Mobile Layout
  Widget _buildCompactTimelineItem(
    int index,
    String role,
    String company,
    String location,
    String duration,
    String description,
    List<String> responsibilities,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Line & Circle Indicator
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryAccent,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryAccent.withOpacity(0.4),
                      blurRadius: 8,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 280, // Approximate height matching card
                width: 2,
                color: AppColors.borderLight,
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Experience card
          Expanded(
            child: GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    duration,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    role,
                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$company — $location",
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: AppColors.borderLight),
                  const SizedBox(height: 12),
                  ...responsibilities.map((resp) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Icon(Icons.circle, size: 6, color: AppColors.primaryAccent),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            resp,
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Desktop Layout
  Widget _buildWideTimelineItem(
    int index,
    String role,
    String company,
    String location,
    String duration,
    String description,
    List<String> responsibilities,
    TextTheme textTheme,
    int totalCount,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Duration and location
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    duration,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.secondaryAccent,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Center: Vertical Line and Bullet Dot
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 22),
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryAccent,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryAccent.withOpacity(0.5),
                      blurRadius: 10,
                    )
                  ],
                ),
              ),
              if (index < totalCount - 1)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.borderLight,
                  ),
                ),
            ],
          ),

          // Right: Content Details Card
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(left: 32, bottom: 40),
              child: GlassCard(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      company,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      description,
                      style: textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.textPrimary.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: AppColors.borderLight),
                    const SizedBox(height: 16),
                    ...responsibilities.map((resp) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Icon(Icons.circle, size: 6, color: AppColors.primaryAccent),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              resp,
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
