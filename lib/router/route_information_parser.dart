import 'package:flutter/material.dart';
import 'package:webview_pwa/router/route_paths.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return AppRoutePath.splash();
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'home') {
        return AppRoutePath.home();
      }
    }

    return AppRoutePath.splash();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isHomePage) {
      return RouteInformation(uri: Uri.parse('/home'));
    }

    return RouteInformation(uri: Uri.parse('/'));
  }
}
