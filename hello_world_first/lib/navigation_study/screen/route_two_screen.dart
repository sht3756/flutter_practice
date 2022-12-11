import 'package:flutter/material.dart';
import 'package:hello_world_first/navigation_study/layout/main_layout.dart';

class RouterTwoScreen extends StatelessWidget {
  const RouterTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(title: 'Router two', children: [
      Text(
        'argument: ${arguments}',
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop')),
    ]);
  }
}
