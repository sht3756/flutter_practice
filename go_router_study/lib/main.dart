import 'package:flutter/material.dart';
import 'package:go_router_study/screen/home_screen.dart';

void main() {
  runApp(_App());
}
class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}


