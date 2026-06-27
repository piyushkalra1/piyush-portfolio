import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  final PageController _pageController = PageController();
  int _currentIdx = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;
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
                const SizedBox(height: 60),

                // Testimonial presentation
                if (isCompact)
                  Column(
                    children: [
                      _buildMobileCarousel(testimonials, textTheme),
                      const SizedBox(height: 16),
                      _buildCarouselDots(testimonials.length),
                    ],
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
        Text(
          "TESTIMONIALS",
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.primaryAccent,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Client Reviews",
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

  Widget _buildMobileCarousel(List<Map<String, dynamic>> items, TextTheme textTheme) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: _pageController,
        itemCount: items.length,
        onPageChanged: (idx) {
          setState(() {
            _currentIdx = idx;
          });
        },
        itemBuilder: (context, idx) {
          return _buildTestimonialCard(items[idx], textTheme);
        },
      ),
    );
  }

  Widget _buildCarouselDots(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (idx) {
        final active = idx == _currentIdx;
        return GestureDetector(
          onTap: () {
            _pageController.animateToPage(
              idx,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: active ? 20 : 8,
            decoration: BoxDecoration(
              color: active ? AppColors.primaryAccent : AppColors.textMuted,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> item, TextTheme textTheme) {
    final quote = item["quote"] as String;
    final client = item["client"] as String;
    final company = item["company"] as String;

    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Quote QuoteMarks
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.format_quote,
                color: AppColors.secondaryAccent,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                quote,
                style: textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
              ),
            ],
          ),
          
          // Client Bio
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryAccent.withOpacity(0.1),
                  radius: 20,
                  child: const Icon(Icons.person, color: AppColors.primaryAccent, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      company,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
