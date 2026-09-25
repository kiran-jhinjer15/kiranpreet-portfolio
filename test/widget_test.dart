import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiran_portfolio/app/app.dart';
import 'package:kiran_portfolio/app/routes/app_routes.dart';
import 'package:kiran_portfolio/app/theme/accent_theme.dart';
import 'package:kiran_portfolio/app/theme/app_colors.dart';
import 'package:kiran_portfolio/app/theme/app_theme.dart';
import 'package:kiran_portfolio/app/theme/theme_controller.dart';
import 'package:kiran_portfolio/features/projects/data/project_assets.dart';
import 'package:kiran_portfolio/features/projects/data/projects_data.dart';
import 'package:kiran_portfolio/features/projects/presentation/pages/project_case_study_page.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/project_screenshot_gallery.dart';
import 'package:kiran_portfolio/core/config/site_config.dart';
import 'package:kiran_portfolio/core/constants/app_constants.dart';
import 'package:kiran_portfolio/core/constants/app_links.dart';
import 'package:kiran_portfolio/features/contact/data/contact_data.dart';
import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';
import 'package:kiran_portfolio/core/navigation/section_request.dart';
import 'package:kiran_portfolio/features/about/presentation/about_page.dart';
import 'package:kiran_portfolio/features/contact/presentation/widgets/contact_form.dart';
import 'package:kiran_portfolio/features/contact/presentation/contact_page.dart';
import 'package:kiran_portfolio/features/experience/presentation/experience_page.dart';
import 'package:kiran_portfolio/features/home/presentation/home_page.dart';
import 'package:kiran_portfolio/features/projects/presentation/projects_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(AppRouter.reset);

  Future<void> setSurface(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('Portfolio app starts with routing and theming', (tester) async {
    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('KIRANPREET'), findsNWidgets(2));
    expect(find.byType(FloatingActionButton), findsNothing);
    expect(find.byIcon(Icons.add), findsNothing);

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.system);
    expect(app.theme?.brightness, Brightness.light);
    expect(app.darkTheme?.brightness, Brightness.dark);
    expect(app.theme?.scaffoldBackgroundColor, AppColors.light.background);
    expect(app.darkTheme?.scaffoldBackgroundColor, AppColors.dark.background);
    expect(app.theme?.colorScheme.primary, AppColors.light.accent);
    expect(app.darkTheme?.colorScheme.primary, AppColors.dark.accent);
  });

  testWidgets('uses dark theme when platform brightness is dark', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(Scaffold));
    final theme = Theme.of(context);
    expect(theme.brightness, Brightness.dark);
    expect(theme.scaffoldBackgroundColor, AppColors.dark.background);
    expect(theme.colorScheme.primary, AppColors.dark.accent);
    expect(theme.textTheme.headlineLarge?.color, AppColors.dark.textPrimary);
  });

  testWidgets('uses light theme when platform brightness is light', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(Scaffold));
    final theme = Theme.of(context);
    expect(theme.brightness, Brightness.light);
    expect(theme.scaffoldBackgroundColor, AppColors.light.background);
    expect(theme.colorScheme.primary, AppColors.light.accent);
    expect(theme.textTheme.headlineLarge?.color, AppColors.light.textPrimary);
  });

  testWidgets('shows desktop navigation links on wide screens', (tester) async {
    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('About'), findsNWidgets(2));
    expect(find.text('Skills'), findsNWidgets(2));
    expect(find.text('Projects'), findsNWidgets(2));
    expect(find.text('Experience'), findsAtLeastNWidgets(1));
    expect(find.text('Contact'), findsNWidgets(2));
    expect(find.byTooltip('Open menu'), findsNothing);
    expect(find.byTooltip('Theme settings'), findsOneWidget);
    expect(find.byTooltip('Switch to dark theme'), findsNothing);
  });

  testWidgets('shows a compact menu on mobile widths', (tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await setSurface(tester, const Size(390, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('KIRANPREET'), findsNWidgets(2));
    expect(find.byTooltip('Open menu'), findsOneWidget);
    expect(find.byTooltip('Theme settings'), findsNothing);
    expect(find.text('Projects'), findsOneWidget);

    await tester.tap(find.byTooltip('Open menu'));
    await tester.pump();
    await tester.pump(AppConstants.motionFast);

    expect(find.text('About'), findsNWidgets(2));
    expect(find.text('Skills'), findsNWidgets(2));
    expect(find.text('Projects'), findsNWidgets(2));
    expect(find.text('Experience'), findsAtLeastNWidgets(1));
    expect(find.text('Contact'), findsNWidgets(2));
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Ocean Blue'), findsOneWidget);

    await tester.tap(find.byTooltip('Close menu'));
    await tester.pump();
    await tester.pump(AppConstants.motionFast);
    expect(find.text('Projects'), findsOneWidget);
  });

  testWidgets('uses compact navigation on tablet widths', (tester) async {
    await setSurface(tester, const Size(800, 1024));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.byTooltip('Open menu'), findsOneWidget);
    expect(find.byTooltip('Theme settings'), findsNothing);
    expect(find.text('Projects'), findsOneWidget);
  });

  testWidgets('theme menu switches appearance and accent color', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.byType(Scaffold))).brightness,
      Brightness.light,
    );

    await tester.tap(find.byTooltip('Theme settings'));
    await tester.pumpAndSettle();

    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Accent Color'), findsOneWidget);
    expect(find.text('Ocean Blue'), findsOneWidget);
    expect(find.text('Emerald'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.byType(Scaffold))).brightness,
      Brightness.dark,
    );

    await tester.tap(find.text('Emerald'));
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.byType(Scaffold))).colorScheme.primary,
      AccentThemes.emerald.accent,
    );
  });

  testWidgets('mobile menu can change appearance and accent', (tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await setSurface(tester, const Size(390, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Open menu'));
    await tester.pump();
    await tester.pump(AppConstants.motionFast);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(Scaffold))).brightness,
      Brightness.dark,
    );

    await tester.ensureVisible(find.text('Coral'));
    await tester.tap(find.text('Coral'));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(Scaffold))).colorScheme.primary,
      AccentThemes.coral.accent,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('persists appearance and accent after restore', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final controller = await ThemeController.restore();
    addTearDown(controller.dispose);

    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(PortfolioApp(themeController: controller));
    await tester.pumpAndSettle();

    controller
      ..setMode(ThemeMode.dark)
      ..setAccent(AccentThemes.violet);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 20));

    final restored = await ThemeController.restore();
    addTearDown(restored.dispose);
    expect(restored.mode, ThemeMode.dark);
    expect(restored.accentTheme.id, AccentThemes.violet.id);
  });

  testWidgets('navbar Projects scrolls to the Projects section', (
    tester,
  ) async {
    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final heading = find.text("Projects I've built and worked on.");
    expect(tester.getTopLeft(heading).dy, greaterThan(400));

    await tester.tap(find.text('Projects').first);
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(heading).dy, lessThan(220));
    expect(tester.getTopLeft(heading).dy, greaterThan(40));
    expect(tester.takeException(), isNull);
  });

  testWidgets('navbar About scrolls to the About section', (tester) async {
    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final heading = find.text(
      'Turning ideas into production-ready applications.',
    );
    expect(tester.getTopLeft(heading).dy, greaterThan(400));

    await tester.tap(find.text('About').first);
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(heading).dy, lessThan(220));
    expect(tester.getTopLeft(heading).dy, greaterThan(40));
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders the homepage hero', (tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('Kiranpreet Kaur'), findsWidgets);
    expect(find.text('View My Work'), findsOneWidget);
    expect(find.text('Download Resume'), findsNWidgets(2));
    expect(find.text('4+ Years'), findsOneWidget);
    expect(
      find.textContaining('production-ready mobile experiences'),
      findsOneWidget,
    );

    await tester.tap(find.text('View My Work'));
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.text("Projects I've built and worked on.")).dy,
      lessThan(220),
    );
  });

  testWidgets('renders the about section after the hero', (tester) async {
    await setSurface(tester, const Size(1280, 900));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('ABOUT ME'), findsOneWidget);
    expect(
      find.text('Turning ideas into production-ready applications.'),
      findsOneWidget,
    );
    expect(find.text('Flutter Development'), findsOneWidget);
    expect(find.text('Career snapshot'), findsOneWidget);
    expect(find.text('Career progression'), findsOneWidget);
    expect(find.text('Current Flutter Developer'), findsWidgets);
    expect(find.text('Years of professional experience'), findsOneWidget);
  });

  testWidgets('renders the skills section', (tester) async {
    await setSurface(tester, const Size(1280, 900));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('TECHNICAL EXPERTISE'), findsOneWidget);
    expect(
      find.text('Tools I use to build production applications.'),
      findsOneWidget,
    );
    expect(find.text('Flutter & Mobile'), findsOneWidget);
    expect(find.text('State & Architecture'), findsOneWidget);
    expect(find.text('Backend & APIs'), findsOneWidget);
    expect(find.text('Payments & Integrations'), findsOneWidget);
    expect(find.text('Tools & Platforms'), findsOneWidget);
    expect(find.text('Development & Quality'), findsOneWidget);
    expect(find.text('Flutter Web'), findsOneWidget);
    expect(find.text('Riverpod'), findsWidgets);
    expect(find.text('Appwrite'), findsOneWidget);
    expect(find.text('Stripe'), findsWidgets);
    expect(find.text('Google Play Console'), findsOneWidget);
    expect(find.text('Performance Optimization'), findsNWidgets(2));
    expect(find.text('React'), findsNothing);
    expect(find.text('Firebase'), findsNothing);
  });

  testWidgets('navbar Skills scrolls to the Skills section', (tester) async {
    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final heading = find.text('Tools I use to build production applications.');
    expect(tester.getTopLeft(heading).dy, greaterThan(400));

    await tester.tap(find.text('Skills').first);
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(heading).dy, lessThan(220));
    expect(tester.getTopLeft(heading).dy, greaterThan(40));
    expect(tester.takeException(), isNull);
  });

  testWidgets('stacks the hero on mobile widths', (tester) async {
    await setSurface(tester, const Size(390, 900));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('View My Work'), findsOneWidget);
    expect(find.text('Download Resume'), findsNWidgets(2));
    expect(find.text('ABOUT ME'), findsOneWidget);
    expect(find.text('Career snapshot'), findsOneWidget);
    expect(find.text('TECHNICAL EXPERTISE'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('navbar Experience scrolls to the Experience section', (
    tester,
  ) async {
    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final heading = find.text(
      'Building products across mobile and production workflows.',
    );
    expect(tester.getTopLeft(heading).dy, greaterThan(400));

    await tester.tap(find.text('Experience').first);
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(heading).dy, lessThan(220));
    expect(tester.getTopLeft(heading).dy, greaterThan(40));
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders the experience timeline', (tester) async {
    await setSurface(tester, const Size(1280, 900));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('PROFESSIONAL EXPERIENCE'), findsOneWidget);
    expect(
      find.text('Building products across mobile and production workflows.'),
      findsOneWidget,
    );
    expect(find.text('LUMESTEA INNOVEX PVT. LTD.'), findsOneWidget);
    expect(find.text('HARDKORE TECH'), findsOneWidget);
    expect(find.text('RICHESTSOFT'), findsOneWidget);
    expect(find.text('WORKS DELIGHT'), findsNWidgets(2));
    expect(find.text('CURRENT'), findsOneWidget);
    expect(find.text('August 2025 – Present'), findsOneWidget);
    expect(find.text('July 2024 – May 2025'), findsOneWidget);
    expect(find.text('August 2022 – June 2024'), findsOneWidget);
    expect(find.text('March 2022 – July 2022'), findsOneWidget);
    expect(find.text('November 2021 – February 2022'), findsOneWidget);
    expect(find.text('Flutter Developer / Team Lead'), findsOneWidget);
    expect(find.text('Flutter Developer Intern'), findsWidgets);
    expect(find.text('Junior Developer'), findsOneWidget);
    expect(find.textContaining('Remote'), findsOneWidget);
    expect(find.text('Career Progression'), findsOneWidget);
    expect(
      find.textContaining('not a list of formal promotions'),
      findsOneWidget,
    );
    expect(find.textContaining('Tracking Tech'), findsWidgets);
    expect(find.text('Show more'), findsNothing);
    expect(find.text('10+ engineers'), findsNothing);
    expect(find.text('promoted'), findsNothing);
  });

  testWidgets('experience cards can expand on mobile', (tester) async {
    await setSurface(tester, const Size(390, 900));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('Show more'), findsWidgets);
    expect(
      find.textContaining('Implementing authentication flows'),
      findsNothing,
    );

    await tester.ensureVisible(find.text('Show more').first);
    await tester.tap(find.text('Show more').first);
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Implementing authentication flows'),
      findsOneWidget,
    );
    expect(find.text('Show less'), findsOneWidget);
  });

  testWidgets('renders education and currently learning after experience', (
    tester,
  ) async {
    await setSurface(tester, const Size(1280, 900));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('EDUCATION'), findsOneWidget);
    expect(find.text('Academic background.'), findsOneWidget);
    expect(find.text('Master of Computer Applications (MCA)'), findsOneWidget);
    expect(
      find.text('Lovely Professional University, Jalandhar'),
      findsOneWidget,
    );
    expect(find.text('Currently Pursuing'), findsOneWidget);
    expect(
      find.text('Bachelor of Computer Applications (BCA)'),
      findsOneWidget,
    );
    expect(find.text('Punjabi University, Patiala'), findsOneWidget);
    expect(find.text('May 2021'), findsOneWidget);
    expect(find.text('Diploma in Computer Applications (DCA)'), findsOneWidget);
    expect(find.text('SITS, Fatehgarh Sahib'), findsOneWidget);
    expect(find.text('2021'), findsOneWidget);
    expect(find.text('CURRENTLY LEARNING'), findsOneWidget);
    expect(
      find.text('Continuously improving my engineering depth.'),
      findsOneWidget,
    );
    expect(find.text('Advanced Dart'), findsOneWidget);
    expect(find.text('Flutter Architecture'), findsOneWidget);
    expect(find.text('Responsive Web Development'), findsOneWidget);
    expect(find.text('Testing'), findsOneWidget);
    expect(find.text('Clean Code & Reusability'), findsOneWidget);
    expect(find.text('CI/CD'), findsOneWidget);
    expect(find.text('System Design for Mobile Applications'), findsOneWidget);
    expect(find.text('Learn'), findsOneWidget);
    expect(find.text('Practice'), findsOneWidget);
    expect(find.text('Build'), findsOneWidget);
    expect(find.text('Improve'), findsOneWidget);
    expect(find.text('Education'), findsNothing);
    expect(find.textContaining('CGPA'), findsNothing);
    expect(find.textContaining('%'), findsNothing);

    final experienceTop = tester
        .getTopLeft(find.text('PROFESSIONAL EXPERIENCE'))
        .dy;
    final educationTop = tester.getTopLeft(find.text('EDUCATION')).dy;
    final learningTop = tester.getTopLeft(find.text('CURRENTLY LEARNING')).dy;
    expect(educationTop, greaterThan(experienceTop));
    expect(learningTop, greaterThan(educationTop));
  });

  testWidgets('education layouts avoid overflow', (tester) async {
    for (final size in const [
      Size(390, 844),
      Size(800, 1024),
      Size(1280, 900),
      Size(1440, 900),
    ]) {
      await setSurface(tester, size);
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      expect(find.text('EDUCATION'), findsOneWidget);
      expect(find.text('CURRENTLY LEARNING'), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('navbar Contact scrolls to the Contact section', (tester) async {
    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    final heading = find.text("Let's build something great together.");
    expect(tester.getTopLeft(heading).dy, greaterThan(400));

    await tester.tap(find.text('Contact').first);
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(heading).dy, lessThan(220));
    expect(tester.getTopLeft(heading).dy, greaterThan(40));
    expect(tester.takeException(), isNull);
  });

  testWidgets('footer follows contact and can return to the top', (
    tester,
  ) async {
    await setSurface(tester, const Size(1280, 800));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter Developer'), findsWidgets);
    expect(
      find.text(
        'Building production-ready mobile and web experiences with Flutter.',
      ),
      findsOneWidget,
    );
    expect(find.text('Built with Flutter'), findsOneWidget);
    expect(find.text('Back to top'), findsOneWidget);
    expect(
      find.text(
        '© ${DateTime.now().year} Kiranpreet Kaur. All rights reserved.',
      ),
      findsOneWidget,
    );

    final contactTop = tester.getTopLeft(find.text('CONTACT')).dy;
    final footerTop = tester.getTopLeft(find.text('Built with Flutter')).dy;
    expect(footerTop, greaterThan(contactTop));

    final footerAbout = find.text('About').last;
    await tester.ensureVisible(footerAbout);
    await tester.tap(footerAbout);
    await tester.pumpAndSettle();

    expect(
      tester
          .getTopLeft(
            find.text('Turning ideas into production-ready applications.'),
          )
          .dy,
      lessThan(220),
    );

    await tester.tap(find.text('Contact').first);
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.text("Let's build something great together.")).dy,
      lessThan(220),
    );

    await tester.ensureVisible(find.text('Back to top'));
    await tester.tap(find.text('Back to top'));
    await tester.pumpAndSettle();

    final heroEyebrow = tester.getTopLeft(find.text('FLUTTER DEVELOPER')).dy;
    expect(heroEyebrow, lessThan(180));
    expect(heroEyebrow, greaterThan(40));
    expect(tester.takeException(), isNull);
  });

  testWidgets('footer layouts avoid overflow', (tester) async {
    for (final size in const [
      Size(390, 844),
      Size(800, 1024),
      Size(1280, 900),
      Size(1440, 900),
    ]) {
      await setSurface(tester, size);
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      expect(find.text('Built with Flutter'), findsOneWidget);
      expect(find.text('Back to top'), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('contact form validates and does not claim a message was sent', (
    tester,
  ) async {
    await setSurface(tester, const Size(1280, 900));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('CONTACT'), findsOneWidget);
    expect(find.text('your.email@example.com'), findsNothing);
    expect(find.text(ContactData.emailUnavailableMessage), findsOneWidget);
    expect(find.text(ContactData.linkedInUnavailableMessage), findsOneWidget);
    expect(find.text(ContactData.githubUnavailableMessage), findsOneWidget);
    expect(
      tester
          .widget<OutlinedButton>(
            find.widgetWithText(OutlinedButton, 'Email Me'),
          )
          .onPressed,
      isNull,
    );
    final resumeButtons = tester.widgetList<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Download Resume'),
    );
    expect(resumeButtons, isNotEmpty);
    expect(resumeButtons.every((button) => button.onPressed == null), isTrue);
    expect(find.text('Punjab, India'), findsOneWidget);
    expect(find.text('Prefer email?'), findsOneWidget);
    expect(find.text('Email Me'), findsOneWidget);
    expect(find.text('Send a message'), findsOneWidget);

    final submit = find.byKey(ContactForm.submitButtonKey);
    await Scrollable.ensureVisible(tester.element(submit), alignment: 0.6);
    await tester.pumpAndSettle();
    await tester.tap(submit);
    await tester.pumpAndSettle();

    expect(find.text('Enter your name.'), findsOneWidget);
    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(find.text('Enter a message.'), findsOneWidget);
    expect(
      find.text('Contact form is ready to connect with a backend.'),
      findsNothing,
    );

    await tester.enterText(find.byKey(ContactForm.nameFieldKey), 'Aman');
    await tester.enterText(
      find.byKey(ContactForm.emailFieldKey),
      'aman@example.com',
    );
    await tester.enterText(
      find.byKey(ContactForm.messageFieldKey),
      'Hello from the portfolio form.',
    );
    await Scrollable.ensureVisible(tester.element(submit), alignment: 0.6);
    await tester.pumpAndSettle();
    await tester.tap(submit);
    await tester.pumpAndSettle();

    expect(
      find.text('Contact form is ready to connect with a backend.'),
      findsOneWidget,
    );
    expect(find.text('Message sent'), findsNothing);
    expect(find.textContaining('email was sent'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('contact layouts avoid overflow', (tester) async {
    for (final size in const [
      Size(390, 844),
      Size(800, 1024),
      Size(1280, 900),
      Size(1440, 900),
    ]) {
      await setSurface(tester, size);
      await tester.pumpWidget(const PortfolioApp());
      await tester.pumpAndSettle();
      expect(find.text('CONTACT'), findsOneWidget);
      expect(find.text('Send a message'), findsOneWidget);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('renders featured and other projects without fake links', (
    tester,
  ) async {
    await setSurface(tester, const Size(1280, 900));
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('SELECTED WORK'), findsOneWidget);
    expect(find.text("Projects I've built and worked on."), findsOneWidget);
    expect(find.text('Daawat'), findsWidgets);
    expect(find.text('ViewGhana'), findsWidgets);
    expect(find.text('Bumper Buds'), findsWidgets);
    expect(find.text('Other Projects'), findsOneWidget);
    expect(find.text('Age Calculator Pro'), findsOneWidget);
    expect(find.text('Siesta Travel'), findsOneWidget);
    expect(find.text('ABMG'), findsOneWidget);
    expect(find.text('Night Light'), findsOneWidget);
    expect(find.text('ViewGhana Vendor'), findsOneWidget);
    expect(find.text('LIVE'), findsOneWidget);
    expect(find.text('View Case Study'), findsNWidgets(3));
    expect(find.text('App Store'), findsNothing);
    expect(find.text('Google Play'), findsNothing);
    expect(find.text('PROJECT VISUAL'), findsWidgets);
  });

  testWidgets('renders a factual case study without invented links', (
    tester,
  ) async {
    await setSurface(tester, const Size(1280, 900));
    final controller = ThemeController();
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      ThemeScope(
        controller: controller,
        child: MaterialApp(
          theme: AppTheme.light(accent: controller.accentTheme),
          darkTheme: AppTheme.dark(accent: controller.accentTheme),
          home: ProjectCaseStudyPage(
            project: ProjectsData.daawat,
            onBack: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Back to Projects'), findsOneWidget);
    expect(
      tester.widget<Title>(find.byType(Title).last).title,
      'Daawat | Kiranpreet Kaur',
    );
    expect(find.text('Daawat'), findsWidgets);
    expect(find.text('Project Overview'), findsOneWidget);
    expect(find.text('My Contribution'), findsOneWidget);
    expect(find.text('Product Flow'), findsOneWidget);
    expect(find.text('Technical Highlights'), findsOneWidget);
    expect(find.text('Challenges & Approach'), findsOneWidget);
    expect(find.text('Selected Screens'), findsOneWidget);
    expect(find.text('Next Project'), findsOneWidget);
    expect(find.text('ViewGhana'), findsOneWidget);
    expect(find.text('App Store'), findsNothing);
    expect(find.text('Google Play'), findsNothing);
    expect(find.text('View My Work'), findsNothing);
    expect(find.text('Other Projects'), findsNothing);
    expect(find.textContaining('download'), findsNothing);
    expect(find.textContaining('revenue'), findsNothing);
  });

  test('deployment placeholders stay unset', () {
    expect(SiteConfig.portfolioUrl, isNull);
    expect(SiteConfig.ogImagePath, isNull);
    expect(AppLinks.email, isNull);
    expect(AppLinks.linkedIn, isNull);
    expect(AppLinks.github, isNull);
    expect(AppLinks.resume, isNull);
    expect(AppLinks.resumeFile, 'assets/resume/kiranpreet_kaur_resume.pdf');
    expect(SiteConfig.email, isNull);
    expect(SiteConfig.linkedInUrl, isNull);
    expect(SiteConfig.githubUrl, isNull);
    expect(ContactData.hasConfiguredEmail, isFalse);
    expect(AppConstants.appTitle, 'Kiranpreet Kaur | Flutter Developer');
    expect(
      AppConstants.caseStudyTitle('ViewGhana'),
      'ViewGhana | Kiranpreet Kaur',
    );
  });

  test('case studies cycle ViewGhana, Bumper Buds, and Daawat', () {
    expect(
      ProjectsData.nextCaseStudy(ProjectsData.viewghana)?.id,
      ProjectsData.bumperBudsId,
    );
    expect(
      ProjectsData.nextCaseStudy(ProjectsData.bumperBuds)?.id,
      ProjectsData.daawatId,
    );
    expect(
      ProjectsData.nextCaseStudy(ProjectsData.daawat)?.id,
      ProjectsData.viewghanaId,
    );
    expect(ProjectsData.bumperBuds.platforms, isEmpty);
  });

  testWidgets('back to projects asks the homepage to open Projects', (
    tester,
  ) async {
    await setSurface(tester, const Size(1280, 900));
    var backedOut = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: ProjectCaseStudyPage(
          project: ProjectsData.daawat,
          onBack: () => backedOut = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Back to Projects'));
    await tester.pump();
    expect(backedOut, isTrue);
    expect(SectionRequest.take(), PortfolioSection.projects);
  });

  test('maps and normalizes the basic portfolio routes', () {
    expect(AppRoutes.normalize('/about/'), AppRoutes.about);
    expect(AppRoutes.normalize('/unknown'), AppRoutes.home);
    expect(AppRoutes.normalize('/projects/daawat'), '/projects/daawat');
    expect(AppRoutes.normalize('/projects/unknown'), AppRoutes.home);
    expect(AppRoutes.pageFor(AppRoutes.about), isA<AboutPage>());
    expect(AppRoutes.pageFor(AppRoutes.projects), isA<ProjectsPage>());
    expect(AppRoutes.pageFor(AppRoutes.experience), isA<ExperiencePage>());
    expect(AppRoutes.pageFor(AppRoutes.contact), isA<ContactPage>());
    expect(AppRoutes.pageFor(AppRoutes.home), isA<HomePage>());
    expect(AppRoutes.pageFor('/projects/daawat'), isA<ProjectCaseStudyPage>());
    expect(
      AppRoutes.pageFor('/projects/viewghana'),
      isA<ProjectCaseStudyPage>(),
    );
    expect(
      AppRoutes.pageFor('/projects/bumper-buds'),
      isA<ProjectCaseStudyPage>(),
    );
  });

  test('keeps screenshot lists empty until real files exist', () {
    expect(
      ProjectAssets.foldersByProjectId,
      hasLength(ProjectsData.all.length),
    );
    for (final project in ProjectsData.all) {
      expect(project.screenshots, isEmpty);
      expect(project.previewAsset, isNull);
      expect(project.thumbnail, isNull);
      expect(project.heroImage, isNull);
      expect(
        project.assetDirectory,
        'assets/projects/${ProjectAssets.foldersByProjectId[project.id]}',
      );
      expect(project.screenshotLabel(0), contains(project.title));
    }
    expect(ProjectsData.daawat.assetDirectory, 'assets/projects/daawat');
    expect(
      ProjectsData.bumperBuds.assetDirectory,
      'assets/projects/bumper_buds',
    );
    expect(
      ProjectsData.viewghanaVendor.assetDirectory,
      'assets/projects/viewghana_vendor',
    );
  });

  testWidgets('screenshot gallery opens and closes without a broken image', (
    tester,
  ) async {
    await setSurface(tester, const Size(1280, 900));
    const project = ProjectData(
      id: 'daawat',
      title: 'Daawat',
      category: 'Restaurant & Delivery Ecosystem',
      description: 'Ordering workflows.',
      role: 'Flutter Developer',
      technologies: [],
      contributions: [],
      screenshots: ['assets/projects/daawat/01.png'],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(body: ProjectScreenshotGallery(project: project)),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.byIcon(Icons.broken_image), findsNothing);
    expect(
      find.text('Daawat, Restaurant & Delivery Ecosystem screen'),
      findsOneWidget,
    );

    await tester.tap(
      find.text('Daawat, Restaurant & Delivery Ecosystem screen'),
    );
    await tester.pumpAndSettle();

    expect(find.byTooltip('Close'), findsOneWidget);
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Close'), findsNothing);
    expect(find.byIcon(Icons.broken_image), findsNothing);
  });

  testWidgets('case study layouts avoid overflow without screenshots', (
    tester,
  ) async {
    for (final size in const [
      Size(390, 844),
      Size(800, 1024),
      Size(1280, 900),
      Size(1440, 900),
    ]) {
      await setSurface(tester, size);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: ProjectCaseStudyPage(
            project: ProjectsData.daawat,
            onBack: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Daawat'), findsWidgets);
      expect(find.text('Selected Screens'), findsOneWidget);
      expect(find.byIcon(Icons.broken_image), findsNothing);
      expect(tester.takeException(), isNull);
    }
  });

  test('resolves accent themes by id with a fallback', () {
    expect(AccentThemes.byId('coral').name, 'Coral');
    expect(AccentThemes.byId('missing'), AccentThemes.oceanBlue);
    expect(AccentThemes.all, hasLength(5));
  });
}
