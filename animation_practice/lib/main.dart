import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Scaffold(body: TestWidget()),
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(milliseconds: 600));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(milliseconds: 600));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(milliseconds: 600));
    _controllerTopCenter =
        ConfettiController(duration: const Duration(milliseconds: 600));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  // 별 그리는 커스텀
  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }

    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Center - custom
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              // 송풍 방향
              blastDirectionality: BlastDirectionality.explosive,
              // 무한 여부
              shouldLoop: false,
              // 색상
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
              // 커스텀 위젯을 넣는 부분
              createParticlePath: drawStar,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: () => checkResults(), child: const Text('응모\n확인')),
          ),

          // TOP CENTER - 아래 방출
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              // 송풍 방향
              blastDirection: pi / 2,
              // 최대 폭발력
              maxBlastForce: 2,
              // 최소 폭발력
              minBlastForce: 1,
              // 방출 빈도
              emissionFrequency: 0.1,
              // 입자 수
              numberOfParticles: 10,
              // 중력
              gravity: 1,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: TextButton(
                onPressed: () {
                  _controllerTopCenter.play();
                },
                child: const Text('당첨(아래로)!')),
          ),

          //BOTTOM CENTER - 위로 방출
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirection: -pi / 2,
              emissionFrequency: 0.01,
              numberOfParticles: 20,
              maxBlastForce: 100,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
                onPressed: () {
                  _controllerBottomCenter.play();
                },
                child: const Text('당첨(위로)!')),
          ),

          //CENTER RIGHT -- 왼쪽 방출
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _controllerCenterRight,
              // 기본 (왼쪽 방출)
              blastDirection: pi,
              // 색 종이에 적용할 드래그 포스를 구성,
              // 0과 1 사이의 값.
              // 예 : 0.1은 많은 드래그를 할수 있지만, 1 은 드래그 불가.
              // 기본 값 :  0.05
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              // 중력 또는 낙하 속도
              gravity: 0.05,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink],
              strokeWidth: 1,
              strokeColor: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  _controllerCenterRight.play();
                },
                child: const Text('당첨(왼쪽)!')),
          ),

          //CENTER LEFT - 오른 쪽으로 방사
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _controllerCenterLeft,
              // 입자 방사 방향을 결정하는 방사형 값.
              // 기본 값은 PI(180도)로 설정, (화면의 왼쪽으로 방출)
              blastDirection: 0,
              // 0 과 1 사이의 값 지정
              // 1 일수록 입자가 단일 프레임 에서 방출될 가능성이 높다.
              // default 0.02 (2% 확률)
              emissionFrequency: 0.6,
              // 색 종이의 최소 입자 크기
              minimumSize: const Size(10, 10),
              // 색 종이의 최대 입자 크기
              maximumSize: const Size(50, 50),
              // 방출될 때의 입자 수.
              // default 10
              numberOfParticles: 1,
              gravity: 0.1,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
                onPressed: () {
                  _controllerCenterLeft.play();
                },
                child: const Text('당첨(오른쪽)!')),
          ),
        ],
      ),
    );
  }

  // Check the results
  Future<void> checkResults() async {
    if (Random().nextBool()) {

      _controllerCenter.play();

      await Future.delayed(const Duration(seconds: 1));

      Get.defaultDialog(
        title: ' 축! 당첨!',
        content: Column(
          children: [
            const Text('제네시스 자동차'),
            Image.asset('assets/images/win.jpeg'),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('당첨 내역 확인'),
            onPressed: () {
              Get.back();
              Get.to(() => const ResultDetailScreen());
            },
          )
        ],
      );
    } else {
      Get.defaultDialog(
        title: '꽝!',
        content: Column(
          children: [
            Image.asset('assets/images/lose.jpeg'),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('다음 기회에 !'),
            onPressed: () {
              Get.back();
            },
          )
        ],
      );
    }
  }
}

// 결과 디테일 페이지
class ResultDetailScreen extends StatelessWidget {
  const ResultDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Text('디테일 정보 페이지'))),
    );
  }
}
