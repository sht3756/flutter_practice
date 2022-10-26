import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Colors.black,
          child: Row(
            // MainAxisAlignment - 주죽 정렬
            // start - 시작
            // end - 끝
            // center - 위젯과 위젯의 사이가 동일하게 배치
            // spaceBetween - 위젯들 사이의 간격이 동일하게 배치
            // spaceEvenly - 위젯들 사이의 간격 동일하게 배치되면서 끝과 끝에는 위젯이 아닌 빈 간격으로 배치
            // spaceAround - spaceEvenly + 끝과 끝의 간격 1/2
            mainAxisAlignment: MainAxisAlignment.spaceAround,

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
        ),
      )

    );
  }
}