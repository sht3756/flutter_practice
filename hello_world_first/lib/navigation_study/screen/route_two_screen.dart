import 'package:flutter/material.dart';
import 'package:hello_world_first/navigation_study/layout/main_layout.dart';
import 'package:hello_world_first/navigation_study/screen/route_three_screen.dart';

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
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/three', arguments: 999);
          },
          child: Text('Push Named')),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => RouterThreeScreen()));
          },
          child: Text('Push Replacment')),
      ElevatedButton(
          // pushAndRemoveUntil
          // (route) => false) 기존에 존재하는 라우트를 기록을 삭제 해준다.
          // (route) => true) 를 하면 라우트된 기록을 살린다.
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => RouterThreeScreen()),
                (route) => false);
          },
          child: Text('Push And Remove Until')),
      ElevatedButton(
          onPressed: () {
            // 특정 라우트만 삭제 할수 있다.

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => RouterThreeScreen()),
                (route) => route.settings.name == '/');
          },
          child: Text('Push And Remove Until'))
    ]);
  }
}
