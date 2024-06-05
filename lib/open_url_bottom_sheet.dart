// class OpenUrlBottomSheet

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenUrlBottomSheet extends StatefulWidget {
  final Uri uri;

  const OpenUrlBottomSheet({super.key, required this.uri});

  @override
  State<OpenUrlBottomSheet> createState() => _OpenUrlBottomSheetState();
}

class _OpenUrlBottomSheetState extends State<OpenUrlBottomSheet> {
  @override
  void initState() {
    super.initState();

    if (mounted) {
      Future.delayed(const Duration(seconds: 5)).then(
        (value) {
          launchUrl(widget.uri, webOnlyWindowName: '_self');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
