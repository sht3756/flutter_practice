import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/route_path.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SplashPage'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'SplashPage',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(onPressed: () => context.push(RoutePath.home), child: Text('go Home')),
          ],
        ),
      ),
    );
  }
}
