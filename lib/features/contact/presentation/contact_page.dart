import 'package:flutter/material.dart';
import 'package:kiran_portfolio/features/contact/presentation/widgets/contact_section.dart';
import 'package:kiran_portfolio/features/home/presentation/widgets/portfolio_shell.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PortfolioShell(body: ContactSection());
  }
}
