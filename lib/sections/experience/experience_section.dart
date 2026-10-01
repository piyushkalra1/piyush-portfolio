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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                _buildSectionHeader(textTheme),
                const SizedBox(height: 60),

                // Timeline List (Direct Column without nested scroll)
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
                    final responsibilities = (exp["responsibilities"] as List).cast<String>();

                    return isCompact
                        ? _buildCompactTimelineItem(index, role, company, location, duration, description, responsibilities, textTheme, expList.length)
                        : _buildWideTimelineItem(index, role, company, location, duration, description, responsibilities, textTheme, expList.length);
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
          "MY EXPERIENCE",
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.primaryAccent,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Career Journey & Impact",
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
    int totalCount,
  ) {
    return IntrinsicHeight(
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
                    color: index == 0 ? AppColors.greenAccent : AppColors.primaryAccent,
                    width: 3.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (index == 0 ? AppColors.greenAccent : AppColors.primaryAccent).withOpacity(0.4),
                      blurRadius: 8,
                    )
                  ],
                ),
              ),
              if (index < totalCount - 1)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    width: 2,
                    color: AppColors.borderLight,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          // Experience card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: GlassCard(
                glowColor: index == 0 ? AppColors.primaryAccent : null,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryAccent.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            duration,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.secondaryAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Text(
                          location,
                          style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      role,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      company,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Divider(color: AppColors.borderLight),
                    const SizedBox(height: 12),
                    ...responsibilities.map((resp) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Icon(Icons.check_circle_outline_rounded, size: 14, color: AppColors.secondaryAccent),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              resp,
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                                height: 1.4,
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
    final isPresent = duration.contains("Present");

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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: isPresent
                          ? AppColors.greenAccent.withOpacity(0.12)
                          : AppColors.secondaryAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isPresent
                            ? AppColors.greenAccent.withOpacity(0.3)
                            : AppColors.secondaryAccent.withOpacity(0.25),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      duration,
                      style: textTheme.titleMedium?.copyWith(
                        color: isPresent ? AppColors.greenAccent : AppColors.secondaryAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
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
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isPresent ? AppColors.greenAccent : AppColors.primaryAccent,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (isPresent ? AppColors.greenAccent : AppColors.primaryAccent).withOpacity(0.5),
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
                glowColor: isPresent ? AppColors.primaryAccent : null,
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            role,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        if (isPresent)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.greenAccent.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: AppColors.greenAccent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "Current Role",
                                  style: TextStyle(
                                    color: AppColors.greenAccent,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      company,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      description,
                      style: textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Divider(color: AppColors.borderLight),
                    const SizedBox(height: 16),
                    ...responsibilities.map((resp) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(Icons.check_circle_outline_rounded, size: 16, color: AppColors.secondaryAccent),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              resp,
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.textPrimary.withOpacity(0.85),
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
