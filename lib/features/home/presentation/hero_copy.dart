abstract final class HeroCopy {
  static const String eyebrow = 'FLUTTER DEVELOPER';
  static const String name = 'Kiranpreet Kaur';

  static const String taglineLead = 'Building ';
  static const String taglineEmphasis = 'production-ready mobile experiences';
  static const String taglineTrail = ' with Flutter.';
  static const String tagline =
      'Building production-ready mobile experiences with Flutter.';

  static const String description =
      'I build production-ready mobile applications for Android and iOS, turning ideas and designs into reliable, scalable digital products.';

  static const String supporting =
      'Experienced in Flutter development, REST API integration, responsive UI, state management, payments, third-party integrations and production application development.';

  static const String viewWork = 'View My Work';
  static const String downloadResume = 'Download Resume';
}

class HeroProofItem {
  const HeroProofItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;
}

abstract final class HeroProofData {
  static const items = [
    HeroProofItem(title: '4+ Years', subtitle: 'Experience'),
    HeroProofItem(title: 'Android + iOS', subtitle: 'Development'),
    HeroProofItem(title: 'Production', subtitle: 'Applications'),
  ];
}
