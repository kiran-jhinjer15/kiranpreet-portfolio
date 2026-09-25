import 'package:flutter/material.dart';
import 'package:kiran_portfolio/features/about/presentation/widgets/about_section.dart';
import 'package:kiran_portfolio/features/contact/presentation/widgets/contact_section.dart';
import 'package:kiran_portfolio/features/education/presentation/widgets/education_section.dart';
import 'package:kiran_portfolio/features/experience/presentation/widgets/experience_section.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/hero_section.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_footer.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_shell.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/projects_section.dart';
import 'package:kiran_portfolio/features/skills/presentation/widgets/skills_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PortfolioShell(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeroSection(),
          AboutSection(),
          SkillsSection(),
          ProjectsSection(),
          ExperienceSection(),
          EducationSection(),
          ContactSection(),
          PortfolioFooter(),
        ],
      ),
    );
  }
}
