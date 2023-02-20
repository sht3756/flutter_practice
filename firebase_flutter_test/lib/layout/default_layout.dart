import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final AppBar? appbar;
  final Widget body;

  const DefaultLayout({
    Key? key,
    this.appbar,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
    );
  }
}
