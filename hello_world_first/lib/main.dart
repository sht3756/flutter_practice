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

// Column Row 추가
void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}



