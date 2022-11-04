import 'package:flutter/material.dart';
import 'package:hello_world_first/screen/home_screen.dart';


// 스플래쉬 스크린 작업 시작
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: HomeScreen(),
//   ));
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF99231),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset('asset/img/logo.png'),
//           CircularProgressIndicator(
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }

// 스플래쉬 스크린 작업 끝

// Column Row 시작
// void main() {
//   runApp(MaterialApp(
//     home: HomeScreen(),
//   ));
// }
// Column Row 끝

// StatefulWidget 시작
// void main() {
//   runApp(MaterialApp(
//     home: Root(),
//   ));
// }
//
// class Root extends StatefulWidget {
//   const Root({Key? key}) : super(key: key);
//
//   @override
//   _RootState createState() => _RootState();
// }
//
// class _RootState extends State<Root> {
//   Color color = Colors.blue;
//   bool show = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Center(
//                   child: show
//                       ? HomeScreen(
//                     color: color,
//                   )
//                       : Container(),
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         color = color == Colors.red ? Colors.blue : Colors.red;
//                       });
//                     },
//                     child: Text(
//                       '색깔 변경하기',
//                     ),
//                   ),
//                   const SizedBox(height: 4.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         show = !show;
//                       });
//                     },
//                     child: Text(
//                       !show ? '위젯 생성하기' : '위젯 삭제하기',
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// StatefulWidget 끝
void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    )
  );
}












