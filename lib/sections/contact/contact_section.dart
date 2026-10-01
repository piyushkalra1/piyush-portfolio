import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/widgets/glass_card.dart';

class ContactSection extends StatefulWidget {
  final ValueChanged<double> onVisible;
  final VoidCallback onDownloadResume;

  const ContactSection({
    super.key,
    required this.onVisible,
    required this.onDownloadResume,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _animate = false;
  final _formKey = GlobalKey<FormState>();
  
  // Text Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await launchUrl(uri)) {
      // url launched
    }
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final subject = _subjectController.text.trim().isNotEmpty
          ? _subjectController.text.trim()
          : "Portfolio Inquiry from $name";
      final message = _messageController.text.trim();

      final mailtoUri = Uri(
        scheme: 'mailto',
        path: AppStrings.emailAddress,
        query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent("Hi Piyush,\n\n$message\n\nBest regards,\n$name\n$email")}',
      );

      await launchUrl(mailtoUri);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  "Opening your email app to send message! Thank you.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            backgroundColor: AppColors.greenAccent,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(20),
          ),
        );

        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = size.width < 900;

    return VisibilityDetector(
      key: const Key('contact_section'),
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

                // Contact Layout
                if (isCompact)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildContactInfo(textTheme),
                      const SizedBox(height: 48),
                      _buildContactForm(textTheme),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: _buildContactInfo(textTheme),
                      ),
                      const SizedBox(width: 60),
                      Expanded(
                        flex: 6,
                        child: _buildContactForm(textTheme),
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
          "GET IN TOUCH",
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.primaryAccent,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Contact Me",
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

  Widget _buildContactInfo(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's connect",
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          "I'm currently open to new senior opportunities, contract work, and custom mobile integrations. Feel free to reach out via email or phone!",
          style: textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 32),

        // Quick contacts
        _buildInfoTile(Icons.email_outlined, "Email Me", AppStrings.emailAddress, "mailto:${AppStrings.emailAddress}"),
        const SizedBox(height: 16),
        _buildInfoTile(Icons.phone_iphone_outlined, "Call Me", AppStrings.phoneNumber, "tel:${AppStrings.phoneNumber.replaceAll(' ', '')}"),
        const SizedBox(height: 16),
        _buildInfoTile(Icons.location_on_outlined, "Location", AppStrings.devLocation, null),
        const SizedBox(height: 32),

        // CTA Row
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildSocialIcon(Icons.code, AppStrings.githubUrl, "GitHub"),
            _buildSocialIcon(Icons.work_outline, AppStrings.linkedinUrl, "LinkedIn"),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: widget.onDownloadResume,
              child: const Text("View Resume"),
            ),
          ],
        ),
      ],
    ).animate(target: _animate ? 1 : 0).fadeIn(delay: 200.ms, duration: 500.ms);
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle, String? url) {
    final isLink = url != null;
    return InkWell(
      onTap: isLink ? () => _launchUrl(url) : null,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryAccent.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryAccent, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isLink ? AppColors.secondaryAccent : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      decoration: isLink ? TextDecoration.underline : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderLight, width: 1),
        ),
        child: IconButton(
          icon: Icon(icon, color: AppColors.textSecondary, size: 20),
          onPressed: () => _launchUrl(url),
          hoverColor: AppColors.primaryAccent.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget _buildContactForm(TextTheme textTheme) {
    return GlassCard(
      glowColor: AppColors.primaryAccent,
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Send a Message",
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            
            // Name Field
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Enter your name",
                prefixIcon: Icon(Icons.person_outline, size: 20, color: AppColors.textMuted),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Enter your email address",
                prefixIcon: Icon(Icons.email_outlined, size: 20, color: AppColors.textMuted),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return "Please enter your email";
                }
                final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegExp.hasMatch(val.trim())) {
                  return "Please enter a valid email address";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Subject Field
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: "Subject",
                hintText: "What is this regarding?",
                prefixIcon: Icon(Icons.subject_outlined, size: 20, color: AppColors.textMuted),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return "Please enter a subject";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Message Field
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Message",
                hintText: "Type your message here...",
                alignLabelWithHint: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: Icon(Icons.chat_bubble_outline, size: 20, color: AppColors.textMuted),
                ),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return "Please enter your message";
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Action Button
            ElevatedButton(
              onPressed: _submitForm,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.send, size: 16),
                  SizedBox(width: 10),
                  Text("Send Message"),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate(target: _animate ? 1 : 0).fadeIn(delay: 300.ms, duration: 600.ms);
  }
}
