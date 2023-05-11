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

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
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
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
            createParticlePath: drawStar, // define a custom shape/path.
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: TextButton(
              onPressed: () {
                winning();
              },
              child: const Text('blast\nstars')),
        ),
      ]),
    );
  }

  void winning() async {
    if (Random().nextBool()) {
      _controllerCenter.play();
      await Future.delayed(const Duration(seconds: 1));

      Get.defaultDialog(
          title: ' 축! 당첨!',
          content: Column(
            children: [
              const Text('제네시스 자동차'),
              Image.network(
                  'https://www.genesis.com/content/dam/genesis-p2/kr/assets/main/awards/genesis-kr-main-jdpower-award-22-mobile-750x376.jpg'),
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
          ]);
    } else {
      Get.defaultDialog(
          title: '꽝!',
          content: Column(
            children: [
              Image.network(
                  'https://mblogthumb-phinf.pstatic.net/MjAxODAxMTBfMjM4/MDAxNTE1NTE0NjI2NTc4.-b0hzSlI19sWpP7Crr-zTXC9tS5sl7TAv3uBi4aYZzEg.YWU1njr3it8Bo6ks4MckMXDZEdoszh07IyS0t3GgHFYg.GIF.zpdebu65/%EA%BD%9D1_rakoon.gif?type=w800'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('다음 기회에 !'),
              onPressed: () {
                Get.back();
              },
            )
          ]);
    }
  }
}

class ResultDetailScreen extends StatelessWidget {
  const ResultDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(child: Text('디테일 정보페이지'))),
    );
  }
}
