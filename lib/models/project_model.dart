class ProjectModel {
  final String id;
  final String name;
  final String shortDescription;
  final String description;
  final List<String> technologies;
  final String playStoreUrl;
  final List<String> features;
  final List<String> screenshots;
  final List<String> responsibilities;
  final double accentHue; // Used to generate custom project-specific gradient blobs

  const ProjectModel({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.technologies,
    required this.playStoreUrl,
    required this.features,
    required this.screenshots,
    required this.responsibilities,
    required this.accentHue,
  });
}
