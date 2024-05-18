// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WebviewPage extends StatelessWidget {
  final Uri uri;

  const WebviewPage({super.key, required this.uri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Webview'),
      ),
      body: Container(
        // color: Colors.white,
        child: WebviewPageBuilder(uri: uri),
      ),
    );
  }
}

class WebviewPageBuilder extends StatefulWidget {
  final Uri uri;

  const WebviewPageBuilder({super.key, required this.uri});

  @override
  State<WebviewPageBuilder> createState() => _WebviewPageBuilderState();
}

class _WebviewPageBuilderState extends State<WebviewPageBuilder> {
  @override
  void initState() {
    super.initState();
    // Load the iframe after the widget build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) => createIframe());
  }

  // Inside your createIframe method in Dart
  void createIframe() {
    Future.delayed(const Duration(milliseconds: 100), () {
      final placeholder = html.document.getElementById('iframe-placeholder');
      if (placeholder != null) {
        final iframe = html.IFrameElement()
          ..src = widget.uri.toString()
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..setAttribute('scrolling', 'yes'); // Enable scrolling explicitly

        placeholder.children.clear(); // Clear previous contents if any
        placeholder.children.add(iframe);

        print('IFrame added: ${placeholder.contains(iframe)}');

        injectScript();
      } else {
        print('Placeholder not found -- ');
      }
    });
  }

  void injectScript() {
    final script = html.ScriptElement()
      ..text = """
    if (document.readyState === 'complete') {
      iframeLoadHandler();
    } else {
      document.addEventListener('DOMContentLoaded', iframeLoadHandler);
    }

    function iframeLoadHandler() {
      const iframe = document.querySelector('iframe');
      if (iframe) {
        iframe.onload = function() {
          console.log('IFrame content loaded');
          captureAllClicks(iframe);
        };
      }
    }
    
    function captureAllClicks(iframe) {
      // Capture all click events on every element within the iframe
      iframe.contentWindow.document.addEventListener('click', function(event) {
        console.log('Click captured:', event.target);
        // You can implement additional logic based on the click target
        // For instance, you can stop certain events or log them to an analytics service
        // event.preventDefault();  // Optional: Prevent the default click action
        // event.stopPropagation(); // Optional: Stop the click event from propagating
      }, true); // Use capture phase to handle the event first
    }
  """;
    html.document.body?.children.add(script);
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: <Widget>[
        Positioned.fill(
          child: HtmlElementView(viewType: 'iframe-placeholder'),
        ),
      ],
    );
  }
}
