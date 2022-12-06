import 'package:flutter/material.dart';

class ConstructorPage extends StatefulWidget {
  const ConstructorPage({Key? key}) : super(key: key);

  @override
  State<ConstructorPage> createState() => _ConstructorPageState();
}

class _ConstructorPageState extends State<ConstructorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const constructor
          // 재실행시 build 함수가 한번 호출되는데, const 인스턴스화를 시켜주면,
          // 앱을 실행하는 동안 단한번의 호출이 된 적있으면, 다시 그릴떄 기억을해서 재호출하지 않는다. (랜더링 부분에서 좋다.)
          // 그럼 const 언제 작성가능할까? 빌드 타임에 어떤값이 들어가 있는지 알수 있을때 작성가능
          const TestWidget(label: 'test1'),
          TestWidget(label: 'test2'),
          ElevatedButton(onPressed: (){
            setState(() {
              // ElevatedButton 을 누르면 build 함수가 당연히 호출되지만,
              // const 로 인스턴스화 시킨 test1 은 print()함수에 출력이 되지 않는걸 볼 수 있다.
            });
          }, child: Text('빌드 !')),
        ],
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    // 어떤 위젯이 빌드되었는지 확인을 위한 print 함수
    print('$label build 실행!');
    return Container();
  }
}
