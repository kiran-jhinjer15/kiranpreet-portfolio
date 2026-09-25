abstract final class AppConstants {
  static const String appName = 'Kiranpreet Kaur';
  static const String appTitle = 'Kiranpreet Kaur | Flutter Developer';
  static const String metaDescription =
      'Portfolio of Kiranpreet Kaur, a Flutter Developer with 4+ years of experience building production-ready mobile and web applications.';


  static const String defaultThemeColor = '#4F7CFF';

  static String caseStudyTitle(String projectTitle) =>
      '$projectTitle | $appName';
  static const String brandName = 'KIRANPREET';

   static const double maxContentWidth = 1200;

  static const Duration motionFast = Duration(milliseconds: 180);
  static const Duration motionMedium = Duration(milliseconds: 220);
  static const Duration motionTheme = Duration(milliseconds: 250);
  static const Duration motionSection = Duration(milliseconds: 600);
  static const Duration motionEntrance = Duration(milliseconds: 720);
}
