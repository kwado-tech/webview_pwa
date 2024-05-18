import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inapp;

class WebviewPage extends StatefulWidget {
  final Uri uri;

  const WebviewPage({super.key, required this.uri});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  Widget build(BuildContext context) {
    final inAppWebViewSettings = inapp.InAppWebViewSettings(
      transparentBackground: true,
      userAgent: 'Flutter-e5oAsiSoYstabuwe',
      isInspectable: true,
    );

    final urlRequest =
        inapp.URLRequest(url: inapp.WebUri(widget.uri.toString()));

    return Scaffold(
      appBar: AppBar(),
      body: inapp.InAppWebView(
        initialUrlRequest: urlRequest,
        onWebViewCreated: (controller) async {
          debugPrint('----- onWebViewCreated: ->:');
          // '----- onWebViewCreated: ->: ${await controller.getIFrameId()}');
        },
        initialSettings: inAppWebViewSettings,
        onLoadStart: (_, url) async {
          // in web url value is coming as the initial uri every time.
          debugPrint('----- Load Start: ->: $url');
        },
        onLoadStop: (controller, url) async {
          debugPrint('----- Load Stop: ->: $url');
        },
        onUpdateVisitedHistory: (controller, url, isReload) {
          debugPrint('----- onUpdateVisitedHistory ->: $url');
          // if (url.toString() == widget.uri.toString()) {
          if (url.toString() == url.toString()) {
            controller.goBack();

            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
