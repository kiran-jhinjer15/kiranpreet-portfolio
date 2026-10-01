import 'package:flutter/material.dart';

abstract final class HeroCopy {
  static const String eyebrow = 'FLUTTER DEVELOPER';
  static const String name = 'Kiranpreet Kaur';

  static const String taglineLead = 'Building ';
  static const String taglineEmphasis = 'production-ready mobile experiences';
  static const String taglineTrail = ' with Flutter.';
  static const String tagline =
      'Building production-ready mobile experiences with Flutter.';

  static const String description =
      'I build production-ready mobile applications for Android and iOS, turning ideas and designs into reliable digital products.';

  static const String supporting =
      'Experienced in Flutter development, REST API integration, responsive UI, state management, payments, third-party integrations and production application development.';

  static const String viewWork = 'View My Work →';
  static const String downloadResume = 'Download Resume';
}

class HeroProofItem {
  const HeroProofItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}

abstract final class HeroTech {
  static const labels = [
    'Flutter',
    'Dart',
    'Android',
    'iOS',
    'REST APIs',
    'GetX',
    'Riverpod',
    'Provider',
    'Appwrite',
    'Stripe',
    'PayPal',
  ];
}

abstract final class HeroProofData {
  static const items = [
    HeroProofItem(
      title: '4+ Years',
      subtitle: 'Experience',
      icon: Icons.work_outline,
    ),
    HeroProofItem(
      title: 'Android + iOS',
      subtitle: 'Development',
      icon: Icons.phone_android,
    ),
    HeroProofItem(
      title: 'Production',
      subtitle: 'Applications',
      icon: Icons.apps_outlined,
    ),
  ];
}
