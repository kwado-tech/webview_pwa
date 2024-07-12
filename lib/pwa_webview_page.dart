// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;

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
      body: SimpleWebView(
        url: uri.toString(),
        onCreated: () {
          print('Iframe created');
        },
        onLoadStart: () {
          print('Load started');
        },
        onLoadStop: () {
          print('Load stopped');
        },
        onUpdateHistory: (url) {
          print('History updated: $url');
        },
      ),
    );
  }
}

class SimpleWebView extends StatefulWidget {
  final String url;
  final VoidCallback? onLoadStart;
  final VoidCallback? onLoadStop;
  final ValueChanged<String>? onUpdateHistory;
  final VoidCallback? onCreated;

  const SimpleWebView({
    Key? key,
    required this.url,
    this.onLoadStart,
    this.onLoadStop,
    this.onUpdateHistory,
    this.onCreated,
  }) : super(key: key);

  @override
  State<SimpleWebView> createState() => _SimpleWebViewState();
}

class _SimpleWebViewState extends State<SimpleWebView> {
  late html.IFrameElement _iframe;

  @override
  void initState() {
    super.initState();

    registerIframeFactory();
  }

  @override
  void dispose() {
    _iframe.remove();

    super.dispose();
  }

  void registerIframeFactory() {
    _iframe = html.IFrameElement()
      ..src = widget.url
      ..style.border = 'none';

    if (widget.onCreated != null) {
      widget.onCreated!();
    }

    _iframe.onLoad.listen((event) {
      if (widget.onLoadStop != null) {
        widget.onLoadStop!();
      }
    });

    _iframe.onError.listen((event) {
      if (widget.onLoadStart != null) {
        widget.onLoadStart!();
      }
    });

    html.window.onPopState.listen((event) {
      if (widget.onUpdateHistory != null) {
        widget.onUpdateHistory!(html.window.location.href);
      }
    });

    html.window.onHashChange.listen((event) {
      if (widget.onUpdateHistory != null) {
        widget.onUpdateHistory!(html.window.location.href);
      }
    });

    ui_web.platformViewRegistry
        .registerViewFactory('iframeElement', (int viewId) => _iframe);
  }

  @override
  Widget build(BuildContext context) {
    return const HtmlElementView(
      viewType: 'iframeElement',
    );
  }
}
