import 'package:kiran_portfolio/core/constants/app_links.dart';
import 'package:kiran_portfolio/core/utils/external_link.dart';

abstract final class ResumeAction {
  static const String? assetPath = AppLinks.resume;

  static bool get isAvailable => assetPath != null && assetPath!.isNotEmpty;

  static const String availableLabel = 'Download resume';

  static const String unavailableLabel = 'Resume is not available yet.';

  static Future<void> open() async {
    final path = assetPath;
    if (path == null || path.isEmpty) {
      return;
    }
    final url = Uri.base.resolve('assets/$path').toString();
    ExternalLink.open(url);
  }
}
