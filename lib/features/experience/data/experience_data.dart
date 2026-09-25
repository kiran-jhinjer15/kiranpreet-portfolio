class ExperienceItem {
  const ExperienceItem({
    required this.company,
    required this.location,
    required this.role,
    required this.period,
    required this.periodShort,
    required this.responsibilities,
    this.additionalRole,
    this.level,
    this.isCurrent = false,
    this.workMode,
    this.projects = const [],
    this.technologies = const [],
  });

  final String company;
  final String location;
  final String role;
  final String period;
  final String periodShort;
  final String? additionalRole;
  final String? level;
  final bool isCurrent;
  final String? workMode;
  final List<String> projects;
  final List<String> responsibilities;
  final List<String> technologies;

  String get displayRole {
    if (additionalRole != null) {
      return '$role / $additionalRole';
    }
    return role;
  }
}

abstract final class ExperienceData {
  static const String eyebrow = 'PROFESSIONAL EXPERIENCE';
  static const String heading =
      'Building products across mobile and production workflows.';
  static const String description =
      "Over 4+ years, I've worked across Flutter applications, API-driven products, responsive interfaces, integrations and production application development.";

  static const String progressionHeading = 'Career Progression';
  static const String progressionDescription =
      'This represents the sequence of professional roles across intern, junior, developer and team-lead responsibilities — not a list of formal promotions.';

  static const List<String> progressionSteps = [
    'Flutter Developer Intern',
    'Junior Flutter Developer',
    'Flutter Developer',
    'Team Lead / Flutter Developer',
    'Current Flutter Developer',
  ];

  static const String currentLabel = 'CURRENT';
  static const String showMoreLabel = 'Show more';
  static const String showLessLabel = 'Show less';

  static const List<ExperienceItem> items = [
    lumestea,
    hardkore,
    richestsoft,
    worksDelightJunior,
    worksDelightIntern,
  ];

  static const ExperienceItem lumestea = ExperienceItem(
    company: 'LUMESTEA INNOVEX PVT. LTD.',
    location: 'Delhi',
    role: 'Flutter Developer',
    period: 'August 2025 – Present',
    periodShort: '2025 — Present',
    isCurrent: true,
    workMode: 'Remote',
    projects: ['Daawat', 'Tracking Tech'],
    technologies: [
      'Flutter',
      'Dart',
      'Riverpod',
      'GetX',
      'REST APIs',
      'Responsive UI',
    ],
    responsibilities: [
      'Working on a Flutter-based food and restaurant application ecosystem, along with a delivery service application.',
      'Developing customer-facing modules including Home, Explore, Services, Orders, Wishlist, Rewards, Balance, Reorder and related flows.',
      'Building reusable Flutter components, with Riverpod for Daawat and GetX for Tracking Tech where applicable.',
      'Implementing authentication flows, API-driven screens, responsive layouts and animations.',
      'Contributing to UI/UX improvements and production-ready mobile application development.',
    ],
  );

  static const ExperienceItem hardkore = ExperienceItem(
    company: 'HARDKORE TECH',
    location: 'Mohali',
    role: 'Flutter Developer',
    additionalRole: 'Team Lead',
    period: 'July 2024 – May 2025',
    periodShort: '2024 — 2025',
    technologies: [
      'Flutter',
      'Dart',
      'Debugging',
      'Performance',
      'Production Apps',
    ],
    responsibilities: [
      'Feature development, delivery and production application maintenance.',
      'Debugging, edge-case handling and performance optimization.',
      'Production application improvements.',
      'Collaboration with backend, design and QA teams.',
      'Worked as Team Lead.',
    ],
  );

  static const ExperienceItem richestsoft = ExperienceItem(
    company: 'RICHESTSOFT',
    location: 'Mohali',
    role: 'Flutter Developer',
    period: 'August 2022 – June 2024',
    periodShort: '2022 — 2024',
    technologies: [
      'Flutter',
      'Dart',
      'REST APIs',
      'Payments',
      'Third-party Integrations',
    ],
    responsibilities: [
      'Developed Flutter applications for Android and iOS.',
      'Built responsive, reusable interfaces and implemented state management and user workflows.',
      'Integrated REST APIs, backend services, third-party services and payment gateways.',
      'Worked on debugging, testing and optimization.',
      'Contributed to production application development and release cycles.',
    ],
  );

  static const ExperienceItem worksDelightJunior = ExperienceItem(
    company: 'WORKS DELIGHT',
    location: 'Mohali',
    role: 'Flutter Developer',
    level: 'Junior Developer',
    period: 'March 2022 – July 2022',
    periodShort: '2022',
    technologies: ['Flutter', 'Dart', 'REST APIs'],
    responsibilities: [
      'Developed Flutter applications for Android and iOS.',
      'Built application UI and reusable Flutter components.',
      'Integrated APIs and implemented application workflows.',
      'Worked on testing, debugging and optimization.',
      'Contributed to production application development.',
    ],
  );

  static const ExperienceItem worksDelightIntern = ExperienceItem(
    company: 'WORKS DELIGHT',
    location: 'Mohali',
    role: 'Flutter Developer Intern',
    period: 'November 2021 – February 2022',
    periodShort: '2021 — 2022',
    technologies: ['Flutter', 'Dart'],
    responsibilities: [
      'Gained practical experience in cross-platform mobile application development.',
      'Worked with Flutter application development workflows.',
      'Built foundational experience in application UI and development.',
    ],
  );
}
