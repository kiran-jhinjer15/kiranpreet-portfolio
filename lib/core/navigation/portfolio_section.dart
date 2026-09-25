enum PortfolioSection {
  about('About'),
  skills('Skills'),
  projects('Projects'),
  experience('Experience'),
  contact('Contact');

  const PortfolioSection(this.label);

  final String label;

  String get id => name;
}
