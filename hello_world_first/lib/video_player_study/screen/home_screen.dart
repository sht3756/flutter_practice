import 'package:flutter/material.dart';

class VideoHomeScreenPage extends StatelessWidget {
  const VideoHomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 공통적인 textStyle 변수선언
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("asset/img/logo.png"),
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'VIDEO',
                style: textStyle,
              ),
              Text(
                'PLAYER',
                style: textStyle.copyWith(
                    fontWeight:
                        FontWeight.w700), // 공통 스타일과 다른 부분은 copyWith() 사용
              )
            ],
          )
        ],
      ),
    ));
  }
}
