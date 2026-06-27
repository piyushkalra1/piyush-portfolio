import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/widgets/glass_card.dart';

class ServicesSection extends StatefulWidget {
  final ValueChanged<double> onVisible;
  const ServicesSection({super.key, required this.onVisible});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;
    final services = AppStrings.servicesData;

    return VisibilityDetector(
      key: const Key('services_section'),
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

                // Grid of Services
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isCompact ? 1 : (size.width < 1100 ? 2 : 3),
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    mainAxisExtent: 220,
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final svc = services[index];
                    final title = svc["title"] as String;
                    final desc = svc["description"] as String;
                    final iconName = svc["iconName"] as String;
                    final color = _getServiceColor(index);

                    return GlassCard(
                      glowColor: color,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Service Icon
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _getIconData(iconName),
                              color: color,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Service Title
                          Text(
                            title,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Service Description
                          Expanded(
                            child: Text(
                              desc,
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
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
          "SERVICES",
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.primaryAccent,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "What I Offer",
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

  Color _getServiceColor(int index) {
    final colors = [
      AppColors.primaryAccent,   // indigo
      AppColors.secondaryAccent, // cyan
      AppColors.violetAccent,    // violet
      AppColors.greenAccent,     // green
      AppColors.pinkAccent,      // pink
      AppColors.orangeAccent,    // orange
      AppColors.redAccent,       // red
      Colors.amber,              // amber
    ];
    return colors[index % colors.length];
  }

  IconData _getIconData(String name) {
    switch (name) {
      case "phone_iphone":
        return Icons.phone_iphone;
      case "android":
        return Icons.android;
      case "apple":
        return Icons.apple;
      case "local_fire_department":
        return Icons.local_fire_department;
      case "sync_alt":
        return Icons.sync_alt;
      case "bug_report":
        return Icons.bug_report;
      case "publish":
        return Icons.publish;
      case "forum":
        return Icons.forum;
      default:
        return Icons.star_border;
    }
  }
}
