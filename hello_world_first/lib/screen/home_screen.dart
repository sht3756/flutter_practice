import 'package:flutter/material.dart';


// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         bottom: false,
//         child: Container(
//           color: Colors.black,
//           child: Column(
//             // MainAxisAlignment - 주죽 정렬
//             // start - 시작
//             // end - 끝
//             // center - 위젯과 위젯의 사이가 동일하게 배치
//             // spaceBetween - 위젯들 사이의 간격이 동일하게 배치
//             // spaceEvenly - 위젯들 사이의 간격 동일하게 배치되면서 끝과 끝에는 위젯이 아닌 빈 간격으로 배치
//             // spaceAround - spaceEvenly + 끝과 끝의 간격 1/2
//             mainAxisAlignment: MainAxisAlignment.start,
//
//             // CrossAxisAlignment - 반대축 정렬
//             // start - 시작
//             // end - 끝
//             // center - 가운데
//             // stretch - 최대한으로 늘린다.
//             crossAxisAlignment: CrossAxisAlignment.start,
//
//             // MainAxisSize 는 주축 크기 조정
//             // max - 최대
//             // min - 최소
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               // Expanded /Flexible
//               Flexible(
//                 flex: 2,
//                 child: Container(
//                   color: Colors.red,
//                   width: 50.0,
//                   height: 50.0,
//                 ),
//               ),
//               Flexible(
//                 child: Container(
//                   color: Colors.orange,
//                   width: 50.0,
//                   height: 50.0,
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   color: Colors.yellow,
//                   width: 50.0,
//                   height: 50.0,
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   color: Colors.green,
//                   width: 50.0,
//                   height: 50.0,
//                 ),
//               )
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.red,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.orange,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.yellow,
                    width: 50.0,
                    height: 50.0,
                  ),Container(
                    color: Colors.green,
                    width: 50.0,
                    height: 50.0,
                  )
                ],
              ),
              Container(
                color: Colors.orange,
                width: 50.0,
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.red,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.orange,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.yellow,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Container(
                    color: Colors.green,
                    width: 50.0,
                    height: 50.0,
                  )
                ],
              ),
              Container(
                color: Colors.green,
                width: 50.0,
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }

}