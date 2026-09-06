import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String kDeveloperPhotoAsset = 'assets/images/raju.jpg';
const String kDeveloperName = 'Md. Mahfuzul Amin RAJU';
const String kDeveloperBatch = 'App Development with Flutter & AI, Batch-17';
const String kProjectName = 'BMI Calculator';
// ---------------------------------------------------------------------

class DeveloperInfoScreen extends StatelessWidget {
  const DeveloperInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      appBar: AppBar(
        title: const Text('Developer Info'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _DeveloperPhoto(assetPath: kDeveloperPhotoAsset),
                SizedBox(height: 24),
                Text(
                  kDeveloperName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  kDeveloperBatch,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                SizedBox(height: 28),
                _ProjectCard(),
                SizedBox(height: 16),
                Text(
                  'Built with Flutter. No backend or database required.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(height: 20),
                _ConnectButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows the developer's photo from assets. Falls back to a placeholder
/// avatar icon if the asset hasn't been added yet, so the app never
/// crashes just because the image file is missing.
class _DeveloperPhoto extends StatelessWidget {
  const _DeveloperPhoto({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE8F5E9),
              child: const Icon(
                Icons.person,
                size: 56,
                color: Color(0xFF4CAF50),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.calculate_outlined,
                size: 18,
                color: Color(0xFF2E7D32),
              ),
              SizedBox(width: 8),
              Text(
                'Project',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E7D32),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            kProjectName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B5E20),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectButtons extends StatelessWidget {
  const _ConnectButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _SocialButton(
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
            _SocialButton(
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
            _SocialButton(
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
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

