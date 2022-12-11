import 'package:flutter/material.dart';
import 'package:hello_world_first/navigation_study/layout/main_layout.dart';
import 'package:hello_world_first/navigation_study/screen/route_two_screen.dart';

class RouterOneScreen extends StatelessWidget {
  final int number;

  const RouterOneScreen({required this.number, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: "Router One", children: [
      Text(
        'argument : ${number.toString()}',
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(456);
        },
        child: Text('Pop'),
      ),
      ElevatedButton(
        onPressed: () {
          // route stack 구조
          // 스택에 차곡 차곡 위로 쌓이게 되며, 최근에 추가한 항목부터 제거가 된다.
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => RouterTwoScreen(),
            // arguments 를 사용해서 인자값 보내기
            settings: RouteSettings(
              arguments: 789,
            )
          ));
        },
        child: Text('Push'),
      ),
    ]);
  }
}
