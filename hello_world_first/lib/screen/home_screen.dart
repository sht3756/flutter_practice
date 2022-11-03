import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

// 실습 프로젝트
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           color: Colors.black,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     color: Colors.red,
//                     width: 50.0,
//                     height: 50.0,
//                   ),
//                   Container(
//                     color: Colors.orange,
//                     width: 50.0,
//                     height: 50.0,
//                   ),
//                   Container(
//                     color: Colors.yellow,
//                     width: 50.0,
//                     height: 50.0,
//                   ),Container(
//                     color: Colors.green,
//                     width: 50.0,
//                     height: 50.0,
//                   )
//                 ],
//               ),
//               Container(
//                 color: Colors.orange,
//                 width: 50.0,
//                 height: 50.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     color: Colors.red,
//                     width: 50.0,
//                     height: 50.0,
//                   ),
//                   Container(
//                     color: Colors.orange,
//                     width: 50.0,
//                     height: 50.0,
//                   ),
//                   Container(
//                     color: Colors.yellow,
//                     width: 50.0,
//                     height: 50.0,
//                   ),
//                   Container(
//                     color: Colors.green,
//                     width: 50.0,
//                     height: 50.0,
//                   )
//                 ],
//               ),
//               Container(
//                 color: Colors.green,
//                 width: 50.0,
//                 height: 50.0,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// blog 웹앱 만들기 시작
// class HomeScreen extends StatelessWidget {
//   WebViewController? controller;
//
//   final homeUrl = 'https://hitang.tistory.com/';
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text('hi my blog'),
//         centerTitle: true,
//         actions: [
//           IconButton(onPressed: (){
//             if(controller == null) {
//               return;
//             }
//             controller!.loadUrl(homeUrl);
//           }, icon: Icon(
//             Icons.home,
//           ))
//         ],
//       ),
//       body: WebView(
//         onWebViewCreated: (WebViewController controller){},
//         // onWebViewCreated: (WebViewController controller){
//         //   this.controller = controller;
//         // },
//
//         initialUrl: homeUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }
// blog 웹앱 만들기 끝

// StatelessWidget 만들기 시작
// class _HomeScreen extends StatelessWidget {
//   final Color color;
//
//   const _HomeScreen({
//     required this.color,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 50.0,
//       height: 50.0,
//       color: color,
//     );
//   }
// }
// StatelessWidget 만들기 끝

// StatefulWidget 만들기 시작
class HomeScreen extends StatefulWidget {
  final Color color;

  HomeScreen({required this.color, Key? key}) : super(key: key) {
    print('Widget Constructor 실행!');
  }

  @override
  State<HomeScreen> createState() {
    print('createState 실행!');
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int number = 0;

  @override
  void initState() {
    super.initState();

    print('initState 실행!');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies 실행!');
  }

  @override
  void deactivate() {
    print('deactivate 실행!');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose 실행!');
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    print('didUpdateWidget 실행!');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('build 실행!');

    return GestureDetector(
      onTap: () {
        setState(() {
          number ++;
        });

      },
      child: Container(
        width: 50.0,
        height: 50.0,
        color: widget.color,
        child: Center(child: Text(number.toString())),
      ),
    );
  }
}
// StatefulWidget 만들기 끝
