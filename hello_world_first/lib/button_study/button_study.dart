import 'package:flutter/material.dart';
import 'package:hello_world_first/random_number_study/constant/color.dart';

class ButtonScreenPage extends StatelessWidget {
  const ButtonScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('버튼 공부'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  // Material State
                  // MaterialStateProperty.all () 어떤 상태에서도 일관되게 정할 수 있다.
                  // MaterialStateProperty.resolveWith() 원하는 상태에 원하는 값을 정할 수 있다.

                  // hovered - 호버링 상태 (마우스 커서를 올려놓은 상태) 모바일에는 존재하지 않는다.
                  // focused - 포커스 된 상태 (텍스트 필드)
                  // pressed - 눌렀을 떄 (o)
                  // dragged - 드래그 됐을때
                  // selected - 선택 됐을때 (체크박스, 라디오 버튼)
                  // scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을떄
                  // disabled - 비활성화 됐을떄 (o)
                  // error - 에러상태 (텍스트 필드)
                  backgroundColor: MaterialStateProperty.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                  return Colors.black;
                },
              ), foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.white;
                }
                return Colors.red;
              }),
              padding: MaterialStateProperty.resolveWith((Set<MaterialState> states)  {
                if(states.contains(MaterialState.pressed)){
                  return EdgeInsets.all(100.0);
                }
                return EdgeInsets.all(20.0);
              } )
              ),

              child: Text('buttonStyle'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  // 메인 컬러 primary -> backgroundColor
                  backgroundColor: RED_COLOR,
                  // 글자 및 애니메이션 onPrimary -> foregroundColor
                  foregroundColor: PRIMARY_COLOR,
                  // 그림자 샐깔
                  shadowColor: Colors.green,
                  // 3D 입체감  z-index 와 같다.수가 높을 수록 앞에 보인다.
                  elevation: 10.0,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                  padding: EdgeInsets.all(32.0),
                  // 테두리
                  side: BorderSide(
                    color: Colors.black,
                    width: 4.0,
                  )),
              child: Text('ElevatedButton'),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                // ElevatedButton 과는 다르게 onPrimary 는 없다.
                // foregroundColor 가 글자색, 애니메이션으로 들어간다.
                foregroundColor: Colors.green,
                // 배경 색상
                backgroundColor: Colors.yellow,
              ),
              child: Text('OutlinedButton'),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                // 글자 색, 애니메이션으로 들어간다.
                foregroundColor: Colors.blue,
                backgroundColor: Colors.pink,
              ),
              child: Text('TextBUtton'),
            )
          ],
        ),
      ),
    );
  }
}
