import 'package:animate_rive/constants.dart';
import 'package:animate_rive/models/rive_asset.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            // TODO: Set mainAxisAlignment
            children: [
              // TODO: Bottom nav items
              ...List.generate(
                  bottomNavs.length,
                  (index) => GestureDetector(
                        onTap: () {
                          // TODO: 탭 시 애니메이션 재생
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //  TODO: Animated Bar
                            SizedBox(
                              height: 36,
                              width: 36,
                              child: Opacity(
                                  opacity: 1,
                                  // TODO: 자식인 선택되지 않을 경우 투명도 변경
                                  child: RiveAnimation.asset(
                                      bottomNavs[index].src,
                                      artboard: bottomNavs[index].artboard,
                                      onInit: (artboard) {
                                    // TODO: 입력값 설정
                                  })),
                            )
                          ],
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
