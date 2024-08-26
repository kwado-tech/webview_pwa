import 'package:webview_pwa/platform_util.dart';

class PlatformUtil extends IPlatformUtil {
  @override
  bool get isChrome => false;

  @override
  bool get isSafari => false;
  
  @override
  bool get isInstalled => false;
}