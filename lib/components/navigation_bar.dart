import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';

class CustomNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> sections;
  final String activeSection;
  final ValueChanged<String> onSectionSelected;
  final VoidCallback onMenuPressed;
  final bool isMobile;

  const CustomNavigationBar({
    super.key,
    required this.sections,
    required this.activeSection,
    required this.onSectionSelected,
    required this.onMenuPressed,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: preferredSize.height,
          decoration: const BoxDecoration(
            color: Color(0x99030303), // Translucent black
            border: Border(
              bottom: BorderSide(color: AppColors.borderLight, width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo PK
                GestureDetector(
                  onTap: () => onSectionSelected("Hero"),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 36,
                        width: 36,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primaryAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "PK",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Piyush Kalra",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Nav Items (Desktop only)
                if (!isMobile)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: sections.map((sec) {
                      final isActive = sec.toLowerCase() == activeSection.toLowerCase();
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: () => onSectionSelected(sec),
                          borderRadius: BorderRadius.circular(8),
                          hoverColor: Colors.white.withOpacity(0.05),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(
                              sec,
                              style: TextStyle(
                                color: isActive ? AppColors.primaryAccent : AppColors.textSecondary,
                                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                // Action button (Desktop) / Menu button (Mobile)
                if (!isMobile)
                  ElevatedButton(
                    onPressed: () => onSectionSelected("Contact"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    child: const Text("Contact Me"),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                    onPressed: onMenuPressed,
                  ),
              ],
            ),
          )
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
