import 'dart:js_interop';

@JS('open')
external JSAny? _windowOpen(JSString url, JSString target, JSString features);

void openExternalUrl(String url) {
  _windowOpen(url.toJS, '_blank'.toJS, 'noopener,noreferrer'.toJS);
}
