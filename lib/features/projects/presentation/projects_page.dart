import 'package:flutter/material.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/editorial_layout.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_shell.dart';
import 'package:kiran_portfolio/features/projects/presentation/widgets/projects_section.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PortfolioShell(
      body: EditorialLayout(child: ProjectsSection()),
    );
  }
}
