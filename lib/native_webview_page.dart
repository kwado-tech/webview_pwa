import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class WebviewPage extends StatefulWidget {
  final Uri uri;

  const WebviewPage._({super.key, required this.uri});

  static Future<void> show(BuildContext context, {required Uri uri}) async {
    return showMaterialModalBottomSheet(
      context: context,
      isDismissible: false,
      // backgroundColor: context.sbMoonTheme.goku100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (_) => WebviewPage._(uri: uri),
    );
  }

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  void initState() {
    super.initState();

    if (mounted) {
      Future.delayed(const Duration(seconds: 2)).then(
        (value) async {
          final isIOSMobileWebPlatform =
              kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS);

          debugPrint('isIOSMobileWebPlatform: $isIOSMobileWebPlatform');

          if (isIOSMobileWebPlatform) {
            await launchUrl(widget.uri, webOnlyWindowName: '_blank');
          } else {
            await launchUrl(widget.uri, webOnlyWindowName: '_self');
          }

          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 20),
      ],
    );
  }
}


// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class WebviewPage extends StatefulWidget {
//   final Uri uri;

//   const WebviewPage({super.key, required this.uri});

//   @override
//   State<WebviewPage> createState() => _WebviewPageState();
// }

// class _WebviewPageState extends State<WebviewPage> {
//   late inapp.InAppWebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     final urlRequest =
//         inapp.URLRequest(url: inapp.WebUri(widget.uri.toString()));

//     final Set<inapp.Sandbox> iframeSandbox = {
//       inapp.Sandbox.ALLOW_DOWNLOADS,
//       inapp.Sandbox.ALLOW_FORMS,
//       inapp.Sandbox.ALLOW_MODALS,
//       inapp.Sandbox.ALLOW_ORIENTATION_LOCK,
//       inapp.Sandbox.ALLOW_POINTER_LOCK,
//       inapp.Sandbox.ALLOW_POPUPS,
//       inapp.Sandbox.ALLOW_POPUPS_TO_ESCAPE_SANDBOX,
//       inapp.Sandbox.ALLOW_PRESENTATION,
//       inapp.Sandbox.ALLOW_SAME_ORIGIN,
//       inapp.Sandbox.ALLOW_SCRIPTS,
//       inapp.Sandbox.ALLOW_TOP_NAVIGATION,
//       // inapp.Sandbox.ALLOW_TOP_NAVIGATION_BY_USER_ACTIVATION,
//     };

//     final inAppWebViewSettings = inapp.InAppWebViewSettings(
//       transparentBackground: true,
//       userAgent: 'Flutter-e5oAsiSoYstabuwe',
//       isInspectable: true,
//       // incognito: isMobileWebPlatform,
//       // cacheEnabled: !isMobileWebPlatform,
//       iframeSandbox: iframeSandbox,
//     );

//     return Scaffold(
//       appBar: AppBar(),
//       body: inapp.InAppWebView(
//         initialUrlRequest: urlRequest,
//         onWebViewCreated: (controller) async {
//           debugPrint('----- onWebViewCreated: ->:');

//           _controller = controller;
//           _addJavaScriptHandler();
//         },
//         initialSettings: inAppWebViewSettings,
//         onLoadStart: (controller, url) async {
//           debugPrint('----- Load Start: ->: $url');
//         },
//         onLoadStop: (controller, url) async {
//           debugPrint('----- Load Stop: ->: $url');
//           await _injectJavaScript();
//         },
//         onNavigationResponse: (controller, navigationResponse) async {
//           return inapp.NavigationResponseAction.ALLOW;
//         },
//         onUpdateVisitedHistory: (controller, url, isReload) {
//           debugPrint('----- onUpdateVisitedHistory ->: $url');
//         },
//         onConsoleMessage: (controller, consoleMessage) {
//           debugPrint('onConsoleMessage ->: ${consoleMessage.message}');
//         },
//       ),
//     );
//   }

//   void _addJavaScriptHandler() {
//     _controller.addJavaScriptHandler(
//       handlerName: 'routeChange',
//       callback: (args) {
//         // Handle the route change here
//         String newRoute = args[0];
//         print('Route changed: $newRoute');
//         // You can add additional handling code here
//       },
//     );
//   }

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
// }
