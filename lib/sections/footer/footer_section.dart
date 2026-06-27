import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';

class FooterSection extends StatelessWidget {
  final ValueChanged<String> onSectionSelected;

  const FooterSection({
    super.key,
    required this.onSectionSelected,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await launchUrl(uri)) {
      // launched
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isCompact = size.width < 900;

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Upper row
              if (isCompact)
                Column(
                  children: [
                    _buildLogo(context),
                    const SizedBox(height: 24),
                    _buildNavLinks(vertical: true),
                    const SizedBox(height: 24),
                    _buildSocials(),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLogo(context),
                    _buildNavLinks(vertical: false),
                    _buildSocials(),
                  ],
                ),
              
              const SizedBox(height: 40),
              const Divider(color: AppColors.borderLight),
              const SizedBox(height: 30),

              // Bottom copyright row
              Row(
                mainAxisAlignment: isCompact ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "© 2026 Piyush Kalra. All rights reserved.",
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  if (!isCompact)
                    Row(
                      children: [
                        Text(
                          "Made with Flutter & ",
                          style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                        ),
                        const Icon(Icons.favorite, color: AppColors.redAccent, size: 12),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return GestureDetector(
      onTap: () => onSectionSelected("Hero"),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: AppColors.primaryAccent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Center(
              child: Text(
                "PK",
                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Piyush Kalra",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavLinks({required bool vertical}) {
    final links = ["Hero", "About", "Skills", "Projects", "Services", "Contact"];
    
    if (vertical) {
      return Column(
        children: links.map((lnk) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () => onSectionSelected(lnk),
            child: Text(
              lnk,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ),
        )).toList(),
      );
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: links.map((lnk) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: () => onSectionSelected(lnk),
          child: Text(
            lnk,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildSocials() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIcon(Icons.code, AppStrings.githubUrl),
        const SizedBox(width: 12),
        _buildIcon(Icons.work_outline, AppStrings.linkedinUrl),
        const SizedBox(width: 12),
        _buildIcon(Icons.email_outlined, "mailto:${AppStrings.emailAddress}"),
      ],
    );
  }

  Widget _buildIcon(IconData icon, String url) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.glassBg,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.textSecondary, size: 16),
        onPressed: () => _launchUrl(url),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
        hoverColor: AppColors.primaryAccent.withOpacity(0.08),
      ),
    );
  }
}
