import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/widgets/glass_card.dart';

class ResumeSection extends StatefulWidget {
  final ValueChanged<double> onVisible;
  const ResumeSection({super.key, required this.onVisible});

  @override
  State<ResumeSection> createState() => _ResumeSectionState();
}

class _ResumeSectionState extends State<ResumeSection> {
  bool _animate = false;

  Future<void> _downloadResume() async {
    // In compiled Flutter web, assets are served at assets/assets/resume/Piyush_Kalra_Resume.pdf
    const url = 'assets/assets/resume/Piyush_Kalra_Resume.pdf';
    final uri = Uri.parse(url);
    if (await launchUrl(uri)) {
      // PDF opened in browser tab
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;

    return VisibilityDetector(
      key: const Key('resume_section'),
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

                // Resume layout
                if (isCompact)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildResumePreview(textTheme),
                      const SizedBox(height: 40),
                      _buildCTAPanel(textTheme, center: true),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: _buildResumePreview(textTheme),
                      ),
                      const SizedBox(width: 60),
                      Expanded(
                        flex: 4,
                        child: _buildCTAPanel(textTheme, center: false),
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
          "RESUME",
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.primaryAccent,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "CV & Credentials",
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

  Widget _buildResumePreview(TextTheme textTheme) {
    return GlassCard(
      glowColor: AppColors.primaryAccent,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resume Mock Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.devName,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    AppStrings.devRole,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(AppStrings.emailAddress, style: textTheme.bodySmall),
                  Text(AppStrings.phoneNumber, style: textTheme.bodySmall),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: 24),

          // Summary mock section
          _buildPreviewSectionHeader("PROFESSIONAL SUMMARY", textTheme),
          const SizedBox(height: 12),
          Text(
            AppStrings.devAboutShort,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary, height: 1.4),
          ),
          const SizedBox(height: 24),

          // Experience mock section (Summary of last roles)
          _buildPreviewSectionHeader("RECENT EXPERIENCE", textTheme),
          const SizedBox(height: 16),
          _buildPreviewExperienceItem(
            "Senior Flutter Developer",
            "Inventco Infotech | Aug 2024 - Present",
            "Develop and maintain complex challenge and cash apps, mentor junior developers.",
            textTheme,
          ),
          const SizedBox(height: 16),
          _buildPreviewExperienceItem(
            "Flutter Developer",
            "Solvebee IT Services | Feb 2023 - Aug 2024",
            "Designed and built Bonanza Care, Probus Insurance, and Government RAS Club.",
            textTheme,
          ),
          const SizedBox(height: 24),

          // Education mock section
          _buildPreviewSectionHeader("EDUCATION", textTheme),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bachelor of Science (BSc)",
                style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              Text(
                "Jul 2017 - Jan 2021",
                style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
          Text(
            "Raj Rishi Bhartri Bhartrihari Matsya University",
            style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    ).animate(target: _animate ? 1 : 0).fadeIn(delay: 200.ms, duration: 600.ms).scale(begin: const Offset(0.98, 0.98), end: const Offset(1, 1));
  }

  Widget _buildPreviewSectionHeader(String title, TextTheme textTheme) {
    return Text(
      title,
      style: textTheme.labelLarge?.copyWith(
        color: AppColors.secondaryAccent,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildPreviewExperienceItem(
    String title,
    String subtitle,
    String desc,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            Text(
              subtitle.split('|')[1].trim(),
              style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
        Text(
          subtitle.split('|')[0].trim(),
          style: textTheme.bodySmall?.copyWith(color: AppColors.primaryAccent, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          desc,
          style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary, height: 1.3),
        ),
      ],
    );
  }

  Widget _buildCTAPanel(TextTheme textTheme, {required bool center}) {
    return Column(
      crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Looking for a printable copy?",
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          "Get the complete detailed ATS-friendly PDF resume showing my full list of projects, certifications, and developer attributes.",
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _downloadResume,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.download, size: 20),
              SizedBox(width: 12),
              Text("Download Resume PDF"),
            ],
          ),
        ),
      ],
    ).animate(target: _animate ? 1 : 0).fadeIn(delay: 350.ms, duration: 500.ms);
  }
}
