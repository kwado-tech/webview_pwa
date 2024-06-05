// ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:webview_pwa/native_webview_page.dart';
// import 'package:webview_pwa/native_webview_page.dart'
//     if (dart.library.html) 'package:webview_pwa/pwa_webview_page.dart';
// import 'package:webview_pwa/fake_platform_view_registry.dart'
//     if (dart.library.html) 'dart:ui_web' as ui show platformViewRegistry;

void main() {
  // registerHtmlElement();

  runApp(const MyApp());
}

// void registerHtmlElement() {
//   // Check if the placeholder is available and register it.
//   ui.platformViewRegistry.registerViewFactory('iframe-placeholder',
//       (int viewId) {
//     final element = html.document.getElementById('iframe-placeholder');
//     if (element == null) {
//       print('Element not found during registration');
//       // Optionally create and insert the element or handle the error.
//       return html
//           .DivElement(); // Return an empty placeholder to avoid breaking.
//     }
//     return element;
//   });
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse('https://flutter.dev/');
    // final uri = Uri.parse('https://static-live.hacksawgaming.com/1067/1.62.0/index.html?language=en&channel=mobile&gameid=1067&mode=2&token=demo&lobbyurl=https%253a%252f%252fstaging.sportsbet.io%252fcasino&partner=demo&env=https://rgs-demo.hacksawgaming.com/api&realmoneyenv=https://rgs-demo.hacksawgaming.com/api&alwaysredirect=true');
    // final uri = Uri.parse('https://files.onetouch.io/game/wild-coyote/latest/index.html?config_id=64011d3e02048a5712ee29e1&session_id=c6a8dd38-d2a7-4e3c-aa6f-6d875806dbc4&lobby_url=https%3A%2F%2Fstaging.sportsbet.io%2Fcasino&deposit_url=&device_platform=mobile&engine_base_url=https://core.ot88.io&sub_partner_id=sportsbet&wrapper_url=https://files.onetouch.io/game/game-wrapper-v3/latest&lang=en&ts=1715236121611');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: WebviewPage(uri: uri),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                // final uri = Uri.parse('https://google.com');
                // final uri = Uri.parse('https://flutter.dev/');
                final uri = Uri.parse(
                    'https://static-live.hacksawgaming.com/1067/1.62.0/index.html?language=en&channel=mobile&gameid=1067&mode=2&token=demo&lobbyurl=https%253a%252f%252fstaging.sportsbet.io%252fcasino&partner=demo&env=https://rgs-demo.hacksawgaming.com/api&realmoneyenv=https://rgs-demo.hacksawgaming.com/api&alwaysredirect=true');

                WebviewPage.show(context, uri: uri);
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //       builder: (context) => WebviewPage.show(uri: uri)),
                // );
              },
              child: const Text('Goto Webview'),
            ),
            const Spacer(),
            const Text('some bottom text'),
          ],
        ),
      ),
    );
  }
}
