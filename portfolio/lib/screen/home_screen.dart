import 'package:flutter/material.dart';
import 'package:portfolio/screen/default_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(appBar: AppBar(),);
  }
}
