import 'package:flutter/material.dart';
import 'package:hello_world_first/navigation_study/layout/main_layout.dart';
import 'package:hello_world_first/navigation_study/screen/route_one_screen.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // true - pop 가능
        // false - pop 불가능
        // android 시스템 뒤로가기 버튼 막기 위함(pop 버튼이 따로 있으면, pop 버튼은 그대로 작동)
        final canPop = Navigator.of(context).canPop();

        return canPop;
      },
      child: MainLayout(
        title: 'Home Screen',
        children: [
          ElevatedButton(
              onPressed: () {
                // pop이 가능하면 true, 불가능하면 , false 리턴
                print(Navigator.of(context).canPop());
              },
              child: Text('canPop')),
          // 많아진 라우트 경로로 routeStack 에 아무것도 없을때, pop() 을 하면 검은색 화면이 출력된다.
          // 그럴때 예외 처리를 maybePop() 을 해주자
          // maybePop() : routeStack 에 pop 할게 있을떄만 pop 해준다.
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              child: Text('maybePop')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('pop')),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => RouterOneScreen(
                        number: 123,
                      )));
              print(result);
            },
            child: Text('Push'),
          ),
        ],
      ),
    );
  }
}
