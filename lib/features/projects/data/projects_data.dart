import 'package:kiran_portfolio/core/constants/app_links.dart';
import 'package:kiran_portfolio/features/projects/data/project_assets.dart';

enum ProjectStatus {
  live('Live'),
  production('Production'),
  personal('Personal'),
  client('Client Project');

  const ProjectStatus(this.label);

  final String label;
}

class ProjectData {
  const ProjectData({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.role,
    required this.technologies,
    required this.contributions,
    this.platforms = const [],
    this.featured = false,
    this.status,
    this.thumbnail,
    this.heroImage,
    this.screenshots = const [],
    this.appStoreUrl,
    this.playStoreUrl,
    this.websiteUrl,
    this.githubUrl,
    this.caseStudyRoute,
    this.ecosystemNote,
  });

  final String id;
  final String title;
  final String category;
  final String description;
  final String role;
  final List<String> technologies;
  final List<String> contributions;
  final List<String> platforms;
  final bool featured;
  final ProjectStatus? status;
  final String? thumbnail;
  final String? heroImage;
  final List<String> screenshots;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final String? websiteUrl;
  final String? githubUrl;
  final String? caseStudyRoute;
  final String? ecosystemNote;

  String? get primaryImage => heroImage ?? thumbnail;

   String? get previewAsset {
    if (screenshots.isNotEmpty) {
      return screenshots.first;
    }
    return primaryImage;
  }

  bool get hasScreenshots => screenshots.isNotEmpty;

  String get assetDirectory => ProjectAssets.directoryFor(id);

   String screenshotLabel(int index) {
    if (screenshots.length <= 1) {
      return '$title, $category screen';
    }
    final last = screenshots.length - 1;
    final safeIndex = index < 0 ? 0 : (index > last ? last : index);
    return '$title, $category screen ${safeIndex + 1} of ${screenshots.length}';
  }

  String get slug => id;

  bool get hasPublicLinks =>
      caseStudyRoute != null ||
      appStoreUrl != null ||
      playStoreUrl != null ||
      websiteUrl != null ||
      githubUrl != null;
}

abstract final class ProjectsData {
  static const String eyebrow = 'SELECTED WORK';
  static const String heading = "Projects I've built and worked on.";
  static const String description =
      "A selection of mobile applications and digital products I've contributed to across different domains, from utility apps and social platforms to restaurant, travel and service-based applications.";
  static const String otherHeading = 'Other Projects';
  static const String contributionHeading = 'My contribution';

   static const List<ProjectData> caseStudies = [viewghana, bumperBuds, daawat];

  static ProjectData? nextCaseStudy(ProjectData project) {
    final index = caseStudies.indexWhere((item) => item.id == project.id);
    if (index == -1) {
      return null;
    }
    return caseStudies[(index + 1) % caseStudies.length];
  }

  static ProjectData? byCaseStudyRoute(String path) {
    for (final project in all) {
      if (project.caseStudyRoute == path) {
        return project;
      }
    }
    return null;
  }

  static const String daawatId = 'daawat';
  static const String viewghanaId = 'viewghana';
  static const String bumperBudsId = 'bumper-buds';

  static const List<ProjectData> all = [
    daawat,
    viewghana,
    bumperBuds,
    ageCalculatorPro,
    siestaTravel,
    abmg,
    nightLight,
    viewghanaVendor,
  ];

  static List<ProjectData> get featured => [
    for (final project in all)
      if (project.featured) project,
  ];

  static List<ProjectData> get other => [
    for (final project in all)
      if (!project.featured) project,
  ];

  static ProjectData? bySlug(String? slug) {
    if (slug == null || slug.isEmpty) {
      return null;
    }
    for (final project in all) {
      if (project.id == slug) {
        return project;
      }
    }
    return null;
  }

  static const ProjectData daawat = ProjectData(
    id: daawatId,
    title: 'Daawat',
    category: 'Restaurant & Delivery Ecosystem',
    description:
        'An integrated restaurant and bakery ecosystem covering customer ordering, services, rewards, order workflows and delivery operations.',
    role: 'Flutter Developer',
    platforms: ['Android', 'iOS', 'Web'],
    technologies: ['Flutter', 'Dart', 'REST API', 'Riverpod', 'Responsive UI'],
    contributions: [
      'Developed Flutter application modules',
      'Built customer-facing interfaces and workflows',
      'Implemented responsive UI',
      'Integrated API-driven screens',
      'Worked with state management',
      'Built reusable Flutter components',
      'Contributed to production application development',
    ],
    featured: true,
    caseStudyRoute: '/projects/$daawatId',
    appStoreUrl: AppLinks.daawatAppStore,
    playStoreUrl: AppLinks.daawatGooglePlay,
    websiteUrl: AppLinks.daawatWebsite,
    githubUrl: AppLinks.daawatGitHub,
  );

  static const ProjectData viewghana = ProjectData(
    id: viewghanaId,
    title: 'ViewGhana',
    category: 'Offers & Service Platform',
    description:
        'A platform connecting users with offers and experiences from restaurants, lounges, cinemas and other businesses in Ghana.',
    role: 'Flutter Developer',
    platforms: ['Android', 'iOS'],
    technologies: ['Flutter', 'Dart', 'REST API', 'QR Code'],
    contributions: [
      'Developed Flutter application interfaces',
      'Integrated REST APIs',
      'Built user-facing workflows',
      'Implemented offer-related functionality',
      'Worked on production application development',
    ],
    ecosystemNote:
        'The project ecosystem also includes a vendor application for QR code scanning, offer validation, offer approval workflows and vendor-side UI.',
    featured: true,
    caseStudyRoute: '/projects/$viewghanaId',
    appStoreUrl: AppLinks.viewghanaAppStore,
    playStoreUrl: AppLinks.viewghanaGooglePlay,
    websiteUrl: AppLinks.viewghanaWebsite,
    githubUrl: AppLinks.viewghanaGitHub,
  );

  static const ProjectData bumperBuds = ProjectData(
    id: bumperBudsId,
    title: 'Bumper Buds',
    category: 'PDF & Payment Application',
    description:
        'A Flutter application that allows users to place customizable banners within PDF documents and purchase banner placements.',
    role: 'Flutter Developer',
    technologies: ['Flutter', 'Dart', 'PDF', 'Stripe'],
    contributions: [
      'Built Flutter interface',
      'Implemented PDF viewing experience',
      'Implemented banner placement workflow',
      'Integrated Stripe payment gateway',
      'Built payment-related application workflows',
    ],
    featured: true,
    caseStudyRoute: '/projects/$bumperBudsId',
    appStoreUrl: AppLinks.bumperBudsAppStore,
    playStoreUrl: AppLinks.bumperBudsGooglePlay,
    websiteUrl: AppLinks.bumperBudsWebsite,
    githubUrl: AppLinks.bumperBudsGitHub,
  );

  static const ProjectData ageCalculatorPro = ProjectData(
    id: 'age-calculator-pro',
    title: 'Age Calculator Pro',
    category: 'Utility Application',
    description:
        'Utility application for age and age-difference calculations with date-based handling including leap years.',
    role: 'Flutter Developer',
    platforms: ['Android', 'iOS'],
    technologies: ['Flutter', 'Dart'],
    contributions: [],
    status: ProjectStatus.live,
    appStoreUrl: AppLinks.ageCalculatorProAppStore,
    playStoreUrl: AppLinks.ageCalculatorProGooglePlay,
    websiteUrl: AppLinks.ageCalculatorProWebsite,
    githubUrl: AppLinks.ageCalculatorProGitHub,
  );

  static const ProjectData siestaTravel = ProjectData(
    id: 'siesta-travel',
    title: 'Siesta Travel',
    category: 'Travel & Service',
    description:
        'Platform connecting tourists with travel guides based on destinations and areas covered, with trip planning and journey-related workflows.',
    role: 'Flutter Developer',
    technologies: ['Flutter', 'Dart'],
    contributions: [],
    appStoreUrl: AppLinks.siestaTravelAppStore,
    playStoreUrl: AppLinks.siestaTravelGooglePlay,
    websiteUrl: AppLinks.siestaTravelWebsite,
    githubUrl: AppLinks.siestaTravelGitHub,
  );

  static const ProjectData abmg = ProjectData(
    id: 'abmg',
    title: 'ABMG',
    category: 'Social Application',
    description:
        'Social platform focused on sharing gratitude and personal stories.',
    role: 'Flutter Developer',
    technologies: ['Flutter', 'Dart'],
    contributions: [],
    appStoreUrl: AppLinks.abmgAppStore,
    playStoreUrl: AppLinks.abmgGooglePlay,
    websiteUrl: AppLinks.abmgWebsite,
    githubUrl: AppLinks.abmgGitHub,
  );

  static const ProjectData nightLight = ProjectData(
    id: 'night-light',
    title: 'Night Light',
    category: 'Utility Application',
    description:
        'Simple night-light application with adjustable brightness and color-changing options.',
    role: 'Flutter Developer',
    technologies: ['Flutter', 'Dart'],
    contributions: [],
    appStoreUrl: AppLinks.nightLightAppStore,
    playStoreUrl: AppLinks.nightLightGooglePlay,
    websiteUrl: AppLinks.nightLightWebsite,
    githubUrl: AppLinks.nightLightGitHub,
  );

  static const ProjectData viewghanaVendor = ProjectData(
    id: 'viewghana-vendor',
    title: 'ViewGhana Vendor',
    category: 'Vendor Application',
    description:
        'Vendor-side application for validating customer offers using QR-code scanning and offer approval workflows.',
    role: 'Flutter Developer',
    technologies: ['Flutter', 'Dart', 'QR Code'],
    contributions: [],
    appStoreUrl: AppLinks.viewghanaVendorAppStore,
    playStoreUrl: AppLinks.viewghanaVendorGooglePlay,
    websiteUrl: AppLinks.viewghanaVendorWebsite,
    githubUrl: AppLinks.viewghanaVendorGitHub,
  );
}
