import 'package:flutter/material.dart';
import 'package:webview_pwa/main.dart';
import 'package:webview_pwa/router/route_paths.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  bool showSplashPage = true;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  AppRoutePath get currentConfiguration {
    if (showSplashPage) {
      return AppRoutePath.splash();
    } else {
      return AppRoutePath.home();
    }
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Flutter Demo Home Page';

    return Navigator(
      key: navigatorKey,
      pages: [
        if (showSplashPage)
          MaterialPage(
            key: const ValueKey('SplashPage'),
            child: SplashPage(onTimeElapsed: _handleTimeElapsed, title: title),
          ),
        if (!showSplashPage)
          const MaterialPage(
            key: ValueKey('HomePage'),
            child: HomePage(title: title),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  void _handleTimeElapsed() {
    showSplashPage = false;
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    if (configuration.isHomePage) {
      showSplashPage = false;
    } else {
      showSplashPage = true;
    }
  }
}
