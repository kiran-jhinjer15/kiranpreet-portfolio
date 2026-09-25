import 'package:kiran_portfolio/core/navigation/portfolio_section.dart';

abstract final class SectionRequest {
  static PortfolioSection? _pending;

  static void request(PortfolioSection section) {
    _pending = section;
  }

  static PortfolioSection? take() {
    final section = _pending;
    _pending = null;
    return section;
  }

  static void clear() {
    _pending = null;
  }
}
