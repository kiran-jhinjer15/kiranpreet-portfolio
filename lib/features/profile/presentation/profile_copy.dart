import 'package:kiran_portfolio/features/about/presentation/about_copy.dart';
import 'package:kiran_portfolio/features/contact/data/contact_data.dart';
import 'package:kiran_portfolio/features/home/presentation/hero_copy.dart';

abstract final class ProfileCopy {
  static const String title = 'Kiranpreet Kaur | Flutter Developer';
  static const String name = HeroCopy.name;
  static const String role = 'Flutter Developer';
  static const String introduction =
      'Flutter Developer building production-ready mobile and web experiences.';
  static const String supporting = HeroCopy.supporting;

  static const String aboutEyebrow = AboutCopy.eyebrow;
  static const String aboutHeading = AboutCopy.heading;
  static const List<String> aboutParagraphs = AboutCopy.paragraphs;
  static const List<String> aboutFocus = AboutCopy.focusAreas;

  static const String snapshotEyebrow = 'PROFESSIONAL SNAPSHOT';
  static const String snapshotHeading = 'A quick view of how I work.';

  static const List<ProfileFact> heroFacts = [
    ProfileFact(label: ContactData.locationValue),
    ProfileFact(label: '4+ Years Experience'),
    ProfileFact(label: 'Flutter / Dart'),
    ProfileFact(label: 'Android + iOS'),
    ProfileFact(label: 'Production Application Development'),
  ];

  static const List<ProfileFact> snapshot = [
    ProfileFact(label: 'Role', value: 'Flutter Developer'),
    ProfileFact(label: 'Experience', value: '4+ Years'),
    ProfileFact(label: 'Location', value: ContactData.locationValue),
    ProfileFact(label: 'Primary Technology', value: 'Flutter / Dart'),
    ProfileFact(label: 'Platforms', value: 'Android, iOS, Flutter Web'),
    ProfileFact(
      label: 'Current Focus',
      value:
          'Advanced Flutter, architecture, responsive web development and performance',
    ),
  ];

  static const String educationEyebrow = 'EDUCATION';
  static const String educationHeading = 'Academic background.';

  static const String journeyEyebrow = 'PROFESSIONAL JOURNEY';
  static const String journeyHeading = 'Roles across the same career path.';
  static const String journeyNote =
      'A concise view of the roles already listed in the portfolio. It is not a list of formal promotions.';

  static const String directionsEyebrow = 'WORK WITH ME';
  static const String directionsHeading =
      "Choose How You'd Like to Work With Me";

  static const String developerTitle = 'Flutter Developer Profile';
  static const String developerSubtitle = 'For Companies';
  static const String developerDescription =
      'Looking for a Flutter developer to join your team or contribute to a production application?';
  static const String developerCta = 'View Developer Portfolio →';

  static const String freelanceTitle = 'Freelance Services';
  static const String freelanceSubtitle = 'For Freelancers';
  static const String freelanceDescription =
      'Need help building, improving, or launching a mobile or web application?';
  static const String freelanceCta = 'Explore Freelance Services →';

  static const String contactEyebrow = 'CONTACT';
  static const String contactHeading = 'Public contact options.';
}

class ProfileFact {
  const ProfileFact({required this.label, this.value});

  final String label;
  final String? value;
}
