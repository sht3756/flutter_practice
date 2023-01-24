import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;

  const DefaultLayout({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('test'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
        ));
  }
}
