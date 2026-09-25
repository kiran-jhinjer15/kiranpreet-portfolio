class AboutCopy {
  const AboutCopy._();

  static const String eyebrow = 'ABOUT ME';
  static const String heading =
      'Turning ideas into production-ready applications.';

  static const List<String> paragraphs = [
    "I'm a Flutter Developer with 4+ years of professional experience building mobile applications for Android and iOS.",
    'I enjoy turning product ideas and designs into reliable, user-friendly applications — from responsive interfaces and reusable components to API integrations, payments and complex application workflows.',
    "Throughout my career, I've worked across different types of products including utility applications, social platforms, travel services, restaurant systems, vendor applications and delivery-focused platforms.",
    "I'm currently focused on deepening my engineering skills in Flutter architecture, responsive development, performance optimization and scalable application design.",
  ];

  static const List<String> focusAreas = [
    'Flutter Development',
    'API & Backend Integration',
    'Responsive UI',
    'Payments & Third-Party Integrations',
    'Production Application Development',
  ];

  static const List<String> stack = ['Flutter', 'Dart', 'Android', 'iOS'];

  static const String snapshotLabel = 'Career snapshot';
  static const String progressionLabel = 'Career progression';
}

class CareerSnapshotItem {
  const CareerSnapshotItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;
}

abstract final class CareerSnapshotData {
  static const items = [
    CareerSnapshotItem(
      title: '4+',
      subtitle: 'Years of professional experience',
    ),
    CareerSnapshotItem(
      title: 'Flutter',
      subtitle: 'Primary development specialization',
    ),
    CareerSnapshotItem(
      title: 'Android + iOS',
      subtitle: 'Cross-platform mobile development',
    ),
    CareerSnapshotItem(
      title: 'Production',
      subtitle: 'Applications shipped and maintained',
    ),
  ];
}

abstract final class CareerProgressionData {
  static const steps = [
    'Flutter Developer Intern',
    'Junior Flutter Developer',
    'Flutter Developer',
    'Team Lead / Flutter Developer',
    'Current Flutter Developer',
  ];
}
