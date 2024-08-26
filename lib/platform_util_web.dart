// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:js' as js;

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

  @override
  bool get isInstalled {
   bool iosStandalone = js.context.hasProperty('navigator') &&
                       js.context['navigator'].hasProperty('standalone') &&
                       js.context['navigator']['standalone'] == true;

    // Check if the app is installed on other platforms
    bool otherPlatformsStandalone =
        html.window.matchMedia('(display-mode: standalone)').matches ||
            html.window.matchMedia('(display-mode: minimal-ui)').matches;

    // Return true if the app is installed on either iOS or other platforms
    return iosStandalone || otherPlatformsStandalone;
  }
}
