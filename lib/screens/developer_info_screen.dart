import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Developer Info Screen
///
/// This screen shows information about the developer of the BMI Calculator app.
/// It includes the developer's name, image placeholder, and project details.
class DeveloperInfoScreen extends StatelessWidget {
  const DeveloperInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Info'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),

            // Developer image
            // Developer image with green border and shadow
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF386A20), width: 4),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF386A20).withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/raju.jpg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),

             const SizedBox(height: 4),

            // Developer name
            Text(
              'Md. Mahfuzul Amin RAJU',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            // Developer title
            Text(
              'Flutter Developer',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF2E7D32),
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 5),

            // Project details card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project Details',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 6),
                    _buildInfoRow(
                      context,
                      label: 'Project Name',
                      value: 'BMI Calculator',
                      icon: Icons.calculate_outlined,
                    ),
                    const SizedBox(height: 6),
                    _buildInfoRow(
                      context,
                      label: 'Assignment',
                      value: 'Module 20',
                      icon: Icons.assignment_outlined,
                    ),
                    const SizedBox(height: 6),
                    _buildInfoRow(
                      context,
                      label: 'Course',
                      value: 'App Development with Flutter & AI',
                      icon: Icons.school_outlined,
                    ),
                    const SizedBox(height: 6),
                    _buildInfoRow(
                      context,
                      label: 'Batch',
                      value: 'Batch-17',
                      icon: Icons.group_outlined,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 3),

            // About section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'This BMI Calculator app was developed as part of Module 20 assignment. '
                      'The app allows users to calculate their Body Mass Index (BMI) by entering '
                      'their weight and height. It provides instant results with visual category '
                      'indicators and follows modern Material 3 design principles.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                            color: const Color(0xFF1B5E20),
                          ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 3),

            // Contact / social section placeholder
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connect',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildSocialButton(
                          context,
                          icon: Icons.email_outlined,
                          label: 'Email',
                          onTap: () async {
                            final Uri emailUri = Uri(
                              scheme: 'mailto',
                              path: 'bd.mahfuzul@gmail.com',
                            );
                            if (await canLaunchUrl(emailUri)) {
                              await launchUrl(emailUri);
                            }
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildSocialButton(
                          context,
                          icon: Icons.link,
                          label: 'Portfolio',
                          onTap: () async {
                            final Uri portfolioUri = Uri.parse(
                              'https://github.com/raju-bd',
                            );
                            if (await canLaunchUrl(portfolioUri)) {
                              await launchUrl(portfolioUri);
                            }
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildSocialButton(
                          context,
                          icon: Icons.code,
                          label: 'GitHub',
                          onTap: () async {
                            final Uri githubUri = Uri.parse(
                              'https://github.com/raju-bd/BMI-Calculator',
                            );
                            if (await canLaunchUrl(githubUri)) {
                              await launchUrl(githubUri);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }

  /// Builds a social/connect button
  Widget _buildSocialButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F8E9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE8F5E9)),
            ),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFF2E7D32), size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1B5E20),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a key-value info row
  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF2E7D32)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF2E7D32),
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1D1B20),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
