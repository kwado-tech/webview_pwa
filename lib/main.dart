// ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:webview_pwa/js_interop_service.dart';
import 'package:webview_pwa/native_webview_page.dart';
import 'package:webview_pwa/router/route_delegate.dart';
import 'package:webview_pwa/router/route_information_parser.dart';

void main() {
  // registerHtmlElement();
  setPathUrlStrategy();
  print("Current path: ${Uri.base.path}");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouterDelegate _routerDelegate = AppRouterDelegate();
  final AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse('https://flutter.dev/');
    // final uri = Uri.parse('https://static-live.hacksawgaming.com/1067/1.62.0/index.html?language=en&channel=mobile&gameid=1067&mode=2&token=demo&lobbyurl=https%253a%252f%252fstaging.sportsbet.io%252fcasino&partner=demo&env=https://rgs-demo.hacksawgaming.com/api&realmoneyenv=https://rgs-demo.hacksawgaming.com/api&alwaysredirect=true');
    // final uri = Uri.parse('https://files.onetouch.io/game/wild-coyote/latest/index.html?config_id=64011d3e02048a5712ee29e1&session_id=c6a8dd38-d2a7-4e3c-aa6f-6d875806dbc4&lobby_url=https%3A%2F%2Fstaging.sportsbet.io%2Fcasino&deposit_url=&device_platform=mobile&engine_base_url=https://core.ot88.io&sub_partner_id=sportsbet&wrapper_url=https://files.onetouch.io/game/game-wrapper-v3/latest&lang=en&ts=1715236121611');

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class SplashPage extends StatefulWidget {
  final String title;
  final VoidCallback onTimeElapsed;

  const SplashPage(
      {super.key, required this.title, required this.onTimeElapsed});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    if (mounted) {
      Future.delayed(const Duration(seconds: 5), widget.onTimeElapsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    if (mounted) {
      final jsInteropService = JsInteropService();
      jsInteropService.showAlert('Hey from flutter');
    }
  }

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
