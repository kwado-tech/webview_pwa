export 'platform_util_native.dart'
    if (dart.library.html) 'platform_util_web.dart';

abstract class IPlatformUtil {
  bool get isChrome;
  bool get isSafari;
}
