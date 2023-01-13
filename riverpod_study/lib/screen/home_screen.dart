import 'package:flutter/material.dart';
import 'package:riverpod_study/layout/default_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HomeScreen',
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('StateProviderScreen'),
          ),
        ],
      ),
    );
  }
}
