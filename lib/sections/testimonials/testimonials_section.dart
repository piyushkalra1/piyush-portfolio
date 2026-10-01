import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/widgets/glass_card.dart';

class TestimonialsSection extends StatefulWidget {
  final ValueChanged<double> onVisible;
  const TestimonialsSection({super.key, required this.onVisible});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  bool _animate = false;

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await launchUrl(uri)) {
      // opened
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 960;
    final testimonials = AppStrings.testimonialsList;

    return VisibilityDetector(
      key: const Key('testimonials_section'),
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
        color: AppColors.background,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                _buildSectionHeader(textTheme),
                const SizedBox(height: 50),

                // Responsive Cards Grid
                if (isCompact)
                  Column(
                    children: testimonials.map((t) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: _buildTestimonialCard(t, textTheme),
                      );
                    }).toList(),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: testimonials.map((t) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: _buildTestimonialCard(t, textTheme),
                        ),
                      );
                    }).toList(),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TESTIMONIALS & REVIEWS",
                  style: textTheme.labelLarge?.copyWith(
                    color: AppColors.primaryAccent,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Real Client Feedback",
                  style: textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.0,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0x1AFBBF24),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x55FBBF24), width: 1.2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.star_rounded, color: Color(0xFFFBBF24), size: 18),
                  SizedBox(width: 6),
                  Text(
                    "5.0 Average Rating",
                    style: TextStyle(
                      color: Color(0xFFFBBF24),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  Widget _buildTestimonialCard(Map<String, dynamic> item, TextTheme textTheme) {
    final quote = item["quote"] as String;
    final client = item["client"] as String;
    final role = item["role"] as String;
    final company = item["company"] as String;
    final sourceBadge = item["sourceBadge"] as String;
    final sourceUrl = item["sourceUrl"] as String;
    final project = item["project"] as String;
    final hasUrl = sourceUrl.isNotEmpty;

    return GlassCard(
      glowColor: AppColors.primaryAccent,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Row: Stars & Badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 5 Gold Stars
                  Row(
                    children: List.generate(5, (_) => const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFBBF24),
                      size: 18,
                    )),
                  ),
                  // Source Badge (Clickable if url available)
                  InkWell(
                    onTap: hasUrl ? () => _launchUrl(sourceUrl) : null,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: hasUrl
                            ? AppColors.primaryAccent.withOpacity(0.12)
                            : AppColors.surfaceCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: hasUrl
                              ? AppColors.primaryAccent.withOpacity(0.35)
                              : AppColors.borderLight,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            hasUrl ? Icons.play_circle_fill_rounded : Icons.verified_rounded,
                            size: 12,
                            color: hasUrl ? AppColors.secondaryAccent : AppColors.greenAccent,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            sourceBadge,
                            style: TextStyle(
                              color: hasUrl ? AppColors.secondaryAccent : AppColors.greenAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Project Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  project,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Quote Text
              Text(
                "\"$quote\"",
                style: textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.textPrimary.withOpacity(0.95),
                  height: 1.55,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),

          // Client Info
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryAccent.withOpacity(0.2),
                        AppColors.secondaryAccent.withOpacity(0.2),
                      ],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryAccent.withOpacity(0.4), width: 1.2),
                  ),
                  child: Center(
                    child: Text(
                      client.isNotEmpty ? client[0] : "C",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "$role • $company",
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
