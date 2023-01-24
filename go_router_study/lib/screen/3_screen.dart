import 'package:flutter/material.dart';
import 'package:go_router_study/layout/default_layout.dart';

class ThreeScreen extends StatelessWidget {
  static String get routename => 'three';

  const ThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: Column(
      children: [],
    ));
  }
}
