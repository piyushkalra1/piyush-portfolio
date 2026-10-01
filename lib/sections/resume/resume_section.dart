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
    const url = 'assets/assets/resume/Piyush_Kalra_Resume.pdf';
    final uri = Uri.parse(url);
    if (await launchUrl(uri)) {
      // PDF opened in browser tab / download triggered
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
                const SizedBox(height: 50),

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: _buildResumePreview(textTheme),
                      ),
                      const SizedBox(width: 50),
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
          "RESUME & CREDENTIALS",
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.primaryAccent,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Curriculum Vitae",
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.devName,
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Flutter Developer | Android & iOS App Developer",
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.greenAccent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.greenAccent.withOpacity(0.3), width: 1),
                ),
                child: const Text(
                  "4+ Years Exp",
                  style: TextStyle(
                    color: AppColors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "${AppStrings.devLocation} | ${AppStrings.phoneNumber} | ${AppStrings.emailAddress}",
            style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted, fontSize: 11.5),
          ),
          const SizedBox(height: 20),
          const Divider(color: AppColors.borderLight, height: 1),
          const SizedBox(height: 20),

          // Summary mock section
          _buildPreviewSectionHeader("PROFESSIONAL SUMMARY", textTheme),
          const SizedBox(height: 8),
          Text(
            "Flutter Developer with 4 years of experience (since October 2022) building scalable Android and iOS applications using Flutter and Dart. Delivered 15+ production applications published on Google Play Store and Apple App Store with a combined reach of 100K+ downloads. Experienced in leading development teams, mentoring Flutter developers, direct client communication, and delivering end-to-end mobile solutions from architecture to deployment.",
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary, height: 1.45, fontSize: 12.5),
          ),
          const SizedBox(height: 22),

          // Experience mock section (Summary of roles)
          _buildPreviewSectionHeader("WORK EXPERIENCE", textTheme),
          const SizedBox(height: 12),
          _buildPreviewExperienceItem(
            "Flutter Developer (Lead)",
            "Inventco Software Pvt. Ltd., Jaipur",
            "Aug 2024 – Present",
            "Led Flutter app development for Android & iOS to production; managed developer team & code reviews; client requirement gathering.",
            textTheme,
          ),
          const SizedBox(height: 14),
          _buildPreviewExperienceItem(
            "Flutter Developer",
            "Solvebee IT Services Pvt. Ltd.",
            "Feb 2023 – Aug 2024",
            "Developed multiple production applications (healthcare, insurance, hospitality); performance optimization; App Store & Play Store publishing.",
            textTheme,
          ),
          const SizedBox(height: 14),
          _buildPreviewExperienceItem(
            "Flutter Intern",
            "Aimerse Technology",
            "Oct 2022 – Dec 2022",
            "Developed responsive Flutter UI, integrated REST APIs using Provider, and collaborated with senior engineers.",
            textTheme,
          ),
          const SizedBox(height: 22),

          // Education mock section
          _buildPreviewSectionHeader("EDUCATION & CERTIFICATIONS", textTheme),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bachelor of Science (BSc)",
                style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary, fontSize: 13),
              ),
              Text(
                "Raj Rishi Bhartrihari Matsya University",
                style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "• Udemy Flutter Bootcamp  • Aimerse Internship Certificate  • Government RSCIT",
            style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary, fontSize: 11.5),
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
        fontSize: 12,
      ),
    );
  }

  Widget _buildPreviewExperienceItem(
    String title,
    String company,
    String duration,
    String desc,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary, fontSize: 13.5),
              ),
            ),
            Text(
              duration,
              style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted, fontSize: 11.5),
            ),
          ],
        ),
        Text(
          company,
          style: textTheme.bodySmall?.copyWith(color: AppColors.primaryAccent, fontWeight: FontWeight.w600, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          desc,
          style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary, height: 1.35, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildCTAPanel(TextTheme textTheme, {required bool center}) {
    return Column(
      crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryAccent.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primaryAccent.withOpacity(0.3), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.description_rounded, size: 14, color: AppColors.secondaryAccent),
              SizedBox(width: 6),
              Text(
                "UPDATED 2026 RESUME",
                style: TextStyle(
                  color: AppColors.secondaryAccent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          "Get the Official 4-Year ATS Resume",
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Download the official printable 2-page ATS resume detailing all 15+ production applications, technical stack (BLoC, Provider, GetX, Clean Architecture, Supabase, Firebase), store release metrics, and client deliverables.",
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
            fontSize: 14.5,
          ),
        ),
        const SizedBox(height: 28),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryAccent, Color(0xFF4F46E5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryAccent.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: _downloadResume,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.download_rounded, size: 20),
                SizedBox(width: 10),
                Text(
                  "Download Resume PDF",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate(target: _animate ? 1 : 0).fadeIn(delay: 350.ms, duration: 500.ms);
  }
}
