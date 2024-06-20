// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:webview_pwa/platform_util.dart';

class PlatformUtil extends IPlatformUtil {
  @override
  bool get isChrome {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    return userAgent.contains('chrome') &&
        !userAgent.contains('edg') &&
        !userAgent.contains('opr');
  }

  @override
  bool get isSafari {
    final userAgent = html.window.navigator.userAgent.toLowerCase();
    return userAgent.contains('safari') &&
        !userAgent.contains('chrome') &&
        !userAgent.contains('crios');
  }
}
