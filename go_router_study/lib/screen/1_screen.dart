import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_study/layout/default_layout.dart';

class OneScreen extends StatelessWidget {
  const OneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          child: Text('pop'),
        ),
      ],
    ));
  }
}
