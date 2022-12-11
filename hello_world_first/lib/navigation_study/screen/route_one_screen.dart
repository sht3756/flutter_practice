import 'package:flutter/material.dart';
import 'package:hello_world_first/navigation_study/layout/main_layout.dart';

class RouterOneScreen extends StatelessWidget {
  const RouterOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: "Router One", children: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Pop'),
      )
    ]);
  }
}
