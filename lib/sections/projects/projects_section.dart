import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/widgets/glass_card.dart';

class ProjectsSection extends StatefulWidget {
  final ValueChanged<double> onVisible;
  const ProjectsSection({super.key, required this.onVisible});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _animate = false;
  String _selectedCategory = "All";

  static const List<String> _categories = [
    "All",
    "IoT & Hardware",
    "Social & Habits",
    "Fintech & Enterprise",
    "E-Learning",
    "Productivity",
  ];

  void _showProjectDetails(BuildContext context, ProjectModel project) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: _ProjectDetailsDialogContent(project: project),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;
    final allProjects = AppStrings.projectsList;
    final filteredProjects = _selectedCategory == "All"
        ? allProjects
        : allProjects.where((p) => p.category == _selectedCategory).toList();

    return VisibilityDetector(
      key: const Key('projects_section'),
      onVisibilityChanged: (info) {
        widget.onVisible(info.visibleFraction);
        if (info.visibleFraction > 0.12 && !_animate) {
          setState(() {
            _animate = true;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        width: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title
                _buildSectionHeader(textTheme),
                const SizedBox(height: 32),

                // Category Filter Tabs
                _buildCategoryFilters(allProjects),
                const SizedBox(height: 40),

                // Grid of Projects
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isCompact ? 1 : (size.width < 1100 ? 2 : 3),
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    mainAxisExtent: 490,
                  ),
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    final project = filteredProjects[index];
                    final color = HSVColor.fromAHSV(1.0, project.accentHue, 0.7, 0.9).toColor();

                    return GlassCard(
                      glowColor: color,
                      padding: EdgeInsets.zero,
                      onTap: () => _showProjectDetails(context, project),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Project Thumbnail Image & Floating Badge
                          Expanded(
                            flex: 5,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: color.withOpacity(0.05),
                                    ),
                                    child: Image.asset(
                                      project.screenshots.isNotEmpty ? project.screenshots.first : '',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        color: AppColors.surfaceCard,
                                        child: Center(
                                          child: Icon(Icons.broken_image_outlined, color: color, size: 40),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Accent hue gradient overlay
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          AppColors.background.withOpacity(0.85),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                // Floating Highlight Badge (e.g., IoT & NFC / RFID Flagship)
                                if (project.highlightBadge != null)
                                  Positioned(
                                    top: 14,
                                    left: 14,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppColors.background.withOpacity(0.88),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: color.withOpacity(0.55), width: 1.2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: color.withOpacity(0.3),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            project.category == "IoT & Hardware"
                                                ? Icons.nfc
                                                : (project.highlightBadge!.contains("★")
                                                    ? Icons.star_rounded
                                                    : Icons.auto_awesome),
                                            color: color,
                                            size: 13,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            project.highlightBadge!,
                                            style: TextStyle(
                                              color: color,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // Project Details
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Category Pill
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 6),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: color.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          project.category.toUpperCase(),
                                          style: TextStyle(
                                            color: color,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        project.name,
                                        style: textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        project.shortDescription,
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: AppColors.textSecondary,
                                          height: 1.35,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  
                                  // Technology Chips
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 6,
                                        children: project.technologies.take(3).map((tech) => Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: color.withOpacity(0.08),
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(color: color.withOpacity(0.2), width: 1),
                                          ),
                                          child: Text(
                                            tech,
                                            style: TextStyle(
                                              color: color,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )).toList(),
                                      ),
                                      const SizedBox(height: 14),
                                      // Action footer
                                      Row(
                                        children: [
                                          Text(
                                            "Explore Project Case",
                                            style: TextStyle(
                                              color: color,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Icon(
                                            Icons.arrow_right_alt,
                                            color: color,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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

  Widget _buildCategoryFilters(List<ProjectModel> allProjects) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: _categories.map((cat) {
          final isSelected = _selectedCategory == cat;
          final count = cat == "All" 
              ? allProjects.length 
              : allProjects.where((p) => p.category == cat).length;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                setState(() {
                  _selectedCategory = cat;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primaryAccent.withOpacity(0.18)
                      : AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.primaryAccent 
                        : AppColors.borderLight,
                    width: isSelected ? 1.5 : 1,
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: AppColors.primaryAccent.withOpacity(0.25),
                      blurRadius: 12,
                      spreadRadius: 1,
                    )
                  ] : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cat,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? AppColors.primaryAccent 
                            : AppColors.borderLight.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$count",
                        style: TextStyle(
                          color: isSelected ? Colors.black : AppColors.textMuted,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "PROVEN PRODUCTION WORK",
              style: textTheme.labelLarge?.copyWith(
                color: AppColors.primaryAccent,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primaryAccent.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryAccent.withOpacity(0.3)),
              ),
              child: const Text(
                "15+ Apps Shipped",
                style: TextStyle(
                  color: AppColors.primaryAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "Featured Projects & Case Studies",
          style: textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Real-world mobile apps engineered for global clients with IoT hardware, Clean Architecture, in-app billing, and buttery 60 FPS performance.",
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            fontSize: 15,
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
}

// Stateful Dialog Content for Carousel State management
class _ProjectDetailsDialogContent extends StatefulWidget {
  final ProjectModel project;
  const _ProjectDetailsDialogContent({required this.project});

  @override
  State<_ProjectDetailsDialogContent> createState() => _ProjectDetailsDialogContentState();
}

class _ProjectDetailsDialogContentState extends State<_ProjectDetailsDialogContent> {
  final PageController _pageController = PageController();
  int _currentImageIdx = 0;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await launchUrl(uri)) {
      // launched
    }
  }

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
    final project = widget.project;
    final color = HSVColor.fromAHSV(1.0, project.accentHue, 0.7, 0.9).toColor();

    return Container(
      constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 750),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Dialog Header
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 20, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      Text(
                        project.name,
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit',
                        ),
                      ),
                      if (project.highlightBadge != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: color.withOpacity(0.4)),
                          ),
                          child: Text(
                            project.highlightBadge!,
                            style: TextStyle(
                              color: color,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () => Navigator.pop(context),
                  hoverColor: Colors.white.withOpacity(0.08),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.borderLight, height: 1),

          // Scrollable Dialog Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: isCompact 
                ? _buildCompactBody(textTheme, color)
                : _buildWideBody(textTheme, color),
            ),
          ),

          // Dialog Footer Actions
          const Divider(color: AppColors.borderLight, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close Details"),
                ),
                const SizedBox(width: 16),
                if (project.playStoreUrl.isNotEmpty)
                  ElevatedButton(
                    onPressed: () => _launchUrl(project.playStoreUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.play_arrow, size: 18),
                        SizedBox(width: 8),
                        Text("View on Play Store"),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.verified_user_outlined, size: 16, color: AppColors.primaryAccent),
                        SizedBox(width: 8),
                        Text(
                          "Enterprise / Client Production App",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
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

  Widget _buildWideBody(TextTheme textTheme, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Screenshots PageView Carousel
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildScreenshotsCarousel(color, 420),
              const SizedBox(height: 16),
              _buildCarouselIndicators(color),
            ],
          ),
        ),

        const SizedBox(width: 40),

        // Right Column: Details Pane
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverviewBlock(textTheme),
              const SizedBox(height: 24),
              _buildResponsibilitiesBlock(textTheme, color),
              const SizedBox(height: 24),
              _buildKeyFeaturesBlock(textTheme, color),
              const SizedBox(height: 24),
              _buildTechStackBlock(textTheme, color),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactBody(TextTheme textTheme, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildScreenshotsCarousel(color, 320),
        const SizedBox(height: 12),
        _buildCarouselIndicators(color),
        const SizedBox(height: 32),
        _buildOverviewBlock(textTheme),
        const SizedBox(height: 28),
        _buildResponsibilitiesBlock(textTheme, color),
        const SizedBox(height: 28),
        _buildKeyFeaturesBlock(textTheme, color),
        const SizedBox(height: 28),
        _buildTechStackBlock(textTheme, color),
      ],
    );
  }

  Widget _buildScreenshotsCarousel(Color color, double height) {
    final screenshots = widget.project.screenshots;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: PageView.builder(
          controller: _pageController,
          itemCount: screenshots.length,
          onPageChanged: (idx) {
            setState(() {
              _currentImageIdx = idx;
            });
          },
          itemBuilder: (context, idx) {
            return Image.asset(
              screenshots[idx],
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: color,
                  size: 48,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCarouselIndicators(Color color) {
    final count = widget.project.screenshots.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (idx) {
        final active = idx == _currentImageIdx;
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
            width: active ? 24 : 8,
            decoration: BoxDecoration(
              color: active ? color : AppColors.textMuted,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildOverviewBlock(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Project Overview",
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.project.description,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildResponsibilitiesBlock(TextTheme textTheme, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Responsibilities",
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...widget.project.responsibilities.map((resp) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Icon(Icons.double_arrow, size: 10, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  resp,
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildKeyFeaturesBlock(TextTheme textTheme, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Features",
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...widget.project.features.map((feat) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_circle_outline, size: 14, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  feat,
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildTechStackBlock(TextTheme textTheme, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tech Stack",
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.project.technologies.map((tech) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.25), width: 1),
            ),
            child: Text(
              tech,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}
