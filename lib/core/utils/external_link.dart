import 'package:kiran_portfolio/core/utils/external_link_stub.dart'
    if (dart.library.js_interop) 'package:kiran_portfolio/core/utils/external_link_web.dart';

abstract final class ExternalLink {
  static String? httpUrl(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    final uri = Uri.tryParse(trimmed);
    if (uri == null || !_isHttp(uri)) {
      return null;
    }
    return trimmed;
  }

  static void open(String url) {
    if (httpUrl(url) == null && _mailto(url) == null) {
      return;
    }
    openExternalUrl(url);
  }

  static String? _mailto(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.scheme != 'mailto' || uri.path.isEmpty) {
      return null;
    }
    return url;
  }

  static bool _isHttp(Uri uri) {
    return (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host.isNotEmpty;
  }
}
