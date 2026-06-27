import 'package:flutter/material.dart';
import 'package:portfolio/components/navigation_bar.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/widgets/mouse_glow_container.dart';

// Sections import (will be created in subsequent steps)
import 'package:portfolio/sections/hero/hero_section.dart';
import 'package:portfolio/sections/about/about_section.dart';
import 'package:portfolio/sections/skills/skills_section.dart';
import 'package:portfolio/sections/experience/experience_section.dart';
import 'package:portfolio/sections/projects/projects_section.dart';
import 'package:portfolio/sections/services/services_section.dart';
import 'package:portfolio/sections/resume/resume_section.dart';
import 'package:portfolio/sections/achievements/achievements_section.dart';
import 'package:portfolio/sections/testimonials/testimonials_section.dart';
import 'package:portfolio/sections/contact/contact_section.dart';
import 'package:portfolio/sections/footer/footer_section.dart';

class MainPortfolioPage extends StatefulWidget {
  final String initialSection;
  const MainPortfolioPage({super.key, this.initialSection = "Hero"});

  @override
  State<MainPortfolioPage> createState() => _MainPortfolioPageState();
}

class _MainPortfolioPageState extends State<MainPortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  
  // Section Navigation keys
  final Map<String, GlobalKey> _sectionKeys = {
    "Hero": GlobalKey(),
    "About": GlobalKey(),
    "Skills": GlobalKey(),
    "Experience": GlobalKey(),
    "Projects": GlobalKey(),
    "Services": GlobalKey(),
    "Resume": GlobalKey(),
    "Achievements": GlobalKey(),
    "Testimonials": GlobalKey(),
    "Contact": GlobalKey(),
  };

  final List<String> _sectionsList = [
    "Hero",
    "About",
    "Skills",
    "Experience",
    "Projects",
    "Services",
    "Resume",
    "Achievements",
    "Testimonials",
    "Contact"
  ];

  String _activeSection = "Hero";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Schedule scroll to initial section if it is not Hero
    if (widget.initialSection != "Hero" && _sectionsList.contains(widget.initialSection)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSection(widget.initialSection);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String sectionName) {
    final key = _sectionKeys[sectionName];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
      setState(() {
        _activeSection = sectionName;
      });
      // Close drawer if open on mobile
      if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
        Navigator.pop(context);
      }
    }
  }

  void _onSectionVisible(String sectionName, double visibleFraction) {
    // Highlight section if it takes up more than 30% of the screen
    if (visibleFraction > 0.3) {
      setState(() {
        _activeSection = sectionName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isMobile ? _buildMobileDrawer() : null,
      body: MouseGlowContainer(
        child: Stack(
          children: [
            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Padding for floating navbar
                    const SizedBox(height: 70),

                    // Sections
                    HeroSection(
                      key: _sectionKeys["Hero"],
                      onVisible: (frac) => _onSectionVisible("Hero", frac),
                      onActionPressed: _scrollToSection,
                    ),
                    AboutSection(
                      key: _sectionKeys["About"],
                      onVisible: (frac) => _onSectionVisible("About", frac),
                    ),
                    SkillsSection(
                      key: _sectionKeys["Skills"],
                      onVisible: (frac) => _onSectionVisible("Skills", frac),
                    ),
                    ExperienceSection(
                      key: _sectionKeys["Experience"],
                      onVisible: (frac) => _onSectionVisible("Experience", frac),
                    ),
                    ProjectsSection(
                      key: _sectionKeys["Projects"],
                      onVisible: (frac) => _onSectionVisible("Projects", frac),
                    ),
                    ServicesSection(
                      key: _sectionKeys["Services"],
                      onVisible: (frac) => _onSectionVisible("Services", frac),
                    ),
                    ResumeSection(
                      key: _sectionKeys["Resume"],
                      onVisible: (frac) => _onSectionVisible("Resume", frac),
                    ),
                    AchievementsSection(
                      key: _sectionKeys["Achievements"],
                      onVisible: (frac) => _onSectionVisible("Achievements", frac),
                    ),
                    TestimonialsSection(
                      key: _sectionKeys["Testimonials"],
                      onVisible: (frac) => _onSectionVisible("Testimonials", frac),
                    ),
                    ContactSection(
                      key: _sectionKeys["Contact"],
                      onVisible: (frac) => _onSectionVisible("Contact", frac),
                      onDownloadResume: () => _scrollToSection("Resume"),
                    ),
                    FooterSection(
                      onSectionSelected: _scrollToSection,
                    ),
                  ],
                ),
              ),
            ),

            // Top Floating Navigation Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomNavigationBar(
                sections: _sectionsList,
                activeSection: _activeSection,
                onSectionSelected: _scrollToSection,
                onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
                isMobile: isMobile,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "PK",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Piyush Kalra",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.borderLight),

            // Drawer Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: _sectionsList.map((sec) {
                  final isActive = sec.toLowerCase() == _activeSection.toLowerCase();
                  return ListTile(
                    title: Text(
                      sec,
                      style: TextStyle(
                        color: isActive ? AppColors.primaryAccent : AppColors.textSecondary,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () => _scrollToSection(sec),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  );
                }).toList(),
              ),
            ),
            
            // Bottom Action
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _scrollToSection("Contact"),
                  child: const Text("Hire Me"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
