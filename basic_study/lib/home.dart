import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Fooderlich',
        style: Theme.of(context).textTheme.headline6,
      )),
      // TODO: Style the body text
      body: Center(
          child: Text(
        'Let\'s get cooking 👩‍🍳',
        style: Theme.of(context).textTheme.headline1,
      )),
    );
  }
}
