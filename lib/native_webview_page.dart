import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;

class WebviewPage extends StatefulWidget {
  final Uri uri;

  const WebviewPage({super.key, required this.uri});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late inapp.InAppWebViewController _controller;

  @override
  Widget build(BuildContext context) {
    final urlRequest =
        inapp.URLRequest(url: inapp.WebUri(widget.uri.toString()));

    final Set<inapp.Sandbox> iframeSandbox = {
      inapp.Sandbox.ALLOW_DOWNLOADS,
      inapp.Sandbox.ALLOW_FORMS,
      inapp.Sandbox.ALLOW_MODALS,
      inapp.Sandbox.ALLOW_ORIENTATION_LOCK,
      inapp.Sandbox.ALLOW_POINTER_LOCK,
      inapp.Sandbox.ALLOW_POPUPS,
      inapp.Sandbox.ALLOW_POPUPS_TO_ESCAPE_SANDBOX,
      inapp.Sandbox.ALLOW_PRESENTATION,
      inapp.Sandbox.ALLOW_SAME_ORIGIN,
      inapp.Sandbox.ALLOW_SCRIPTS,
      inapp.Sandbox.ALLOW_TOP_NAVIGATION,
      // inapp.Sandbox.ALLOW_TOP_NAVIGATION_BY_USER_ACTIVATION,
    };

    final inAppWebViewSettings = inapp.InAppWebViewSettings(
      transparentBackground: true,
      userAgent: 'Flutter-e5oAsiSoYstabuwe',
      isInspectable: true,
      // incognito: isMobileWebPlatform,
      // cacheEnabled: !isMobileWebPlatform,
      // iframeSandbox: iframeSandbox,
    );

    return Scaffold(
      appBar: AppBar(),
      body: inapp.InAppWebView(
        initialUrlRequest: urlRequest,
        onWebViewCreated: (controller) async {
          debugPrint('----- onWebViewCreated: ->:');

          _controller = controller;
          // _addJavaScriptHandler();
        },
        initialSettings: inAppWebViewSettings,
        onLoadStart: (controller, url) async {
          debugPrint('----- Load Start: ->: $url');
        },
        onLoadStop: (controller, url) async {
          debugPrint('----- Load Stop: ->: $url');
          // await _injectJavaScript();
        },
        onNavigationResponse: (controller, navigationResponse) async {
          return inapp.NavigationResponseAction.ALLOW;
        },
        onUpdateVisitedHistory: (controller, url, isReload) {
          debugPrint('----- onUpdateVisitedHistory ->: $url');
        },
        onConsoleMessage: (controller, consoleMessage) {
          debugPrint('onConsoleMessage ->: ${consoleMessage.message}');
        },
      ),
    );
  }

  void _addJavaScriptHandler() {
    _controller.addJavaScriptHandler(
      handlerName: 'routeChange',
      callback: (args) {
        // Handle the route change here
        String newRoute = args[0];
        print('Route changed: $newRoute');
        // You can add additional handling code here
      },
    );
  }

//   Future<void> _injectJavaScript() async {
//     await _controller.evaluateJavascript(source: '''
//       (function() {
//         function observeIframes(context) {
//           var iframes = context.document.querySelectorAll('iframe');
//           iframes.forEach(function(iframe) {
//             var observer = new MutationObserver(function(mutations) {
//               mutations.forEach(function(mutation) {
//                 if (mutation.type === 'attributes' && mutation.attributeName === 'src') {
//                   window.flutter_inappwebview.callHandler('routeChange', iframe.src);
//                 }
//               });
//             });

//             observer.observe(iframe, {
//               attributes: true,
//               attributeFilter: ['src']
//             });
//           });
//         }

//         // Observe iframes in window.top
//         observeIframes(window.top);

//         // Observe iframes in window.parent
//         if (window.parent && window.parent !== window) {
//           observeIframes(window.parent);
//         }
//       })();
//     ''');
//     _controller.addJavaScriptHandler(
//         handlerName: 'routeChange',
//         callback: (args) {
//           // Handle the route change here
//           String newRoute = args[0];
//           print('Route changed: $newRoute');
//           // You can add additional handling code here
//         });
//   }
}
