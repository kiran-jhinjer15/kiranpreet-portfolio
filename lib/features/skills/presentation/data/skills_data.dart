import 'package:flutter/material.dart';

class SkillCategory {
  const SkillCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.skills,
  });

  final String title;
  final String description;
  final IconData icon;
  final List<String> skills;
}

abstract final class SkillsData {
  static const String eyebrow = 'TECHNICAL EXPERTISE';
  static const String heading = 'Tools I use to build production applications.';
  static const String description =
      'My work spans Flutter development, responsive interfaces, API integration, application architecture, payments and third-party services across mobile and web.';

  static const List<SkillCategory> categories = [
    SkillCategory(
      title: 'Flutter & Mobile',
      description:
          'Cross-platform interfaces for Android, iOS, and Flutter Web.',
      icon: Icons.smartphone_outlined,
      skills: [
        'Flutter',
        'Dart',
        'Android',
        'iOS',
        'Flutter Web',
        'Responsive UI',
        'Custom Widgets',
        'Animations',
      ],
    ),
    SkillCategory(
      title: 'State & Architecture',
      description:
          'Structured application architecture and reusable components.',
      icon: Icons.account_tree_outlined,
      skills: [
        'GetX',
        'Riverpod',
        'Provider',
        'Modular Development',
        'Reusable Components',
        'Application Architecture',
      ],
    ),
    SkillCategory(
      title: 'Backend & APIs',
      description: 'API integration, data access, and authentication.',
      icon: Icons.cloud_outlined,
      skills: ['REST APIs', 'Appwrite', 'MySQL', 'Authentication', 'Postman'],
    ),
    SkillCategory(
      title: 'Payments & Integrations',
      description:
          'Payments and third-party SDK integrations in production apps.',
      icon: Icons.credit_card_outlined,
      skills: [
        'Stripe',
        'PayPal',
        'In-App Purchases',
        'QR Code Integration',
        'Third-Party SDK Integration',
        'Flutter Plugin Integration',
      ],
    ),
    SkillCategory(
      title: 'Tools & Platforms',
      description:
          'Version control, release consoles, and supporting platforms.',
      icon: Icons.build_outlined,
      skills: [
        'Git',
        'GitHub',
        'Google Play Console',
        'Apple Developer Console',
        'Meta Developer Console',
        'AWS Fundamentals',
        'FlutterFlow',
      ],
    ),
    SkillCategory(
      title: 'Development & Quality',
      description: 'Debugging, optimization, and production release practices.',
      icon: Icons.verified_outlined,
      skills: [
        'Debugging',
        'Performance Optimization',
        'Edge Case Handling',
        'Usability Testing',
        'Code Reusability',
        'Application Optimization',
        'Production Releases',
      ],
    ),
  ];
}
