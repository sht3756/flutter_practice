import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_study/layout/default_layout.dart';
import 'package:go_router_study/screen/3_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            context.go('/one');
          },
          child: Text(
            'Screen One(GO)',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.go('/two');
          },
          child: Text(
            'Screen Two(GO)',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.goNamed(ThreeScreen.routename);
          },
          child: Text(
            'Screen Three(GO)',
          ),
        ),
      ],
    ));
  }
}
