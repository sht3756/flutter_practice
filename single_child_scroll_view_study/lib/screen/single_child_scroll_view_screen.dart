import 'package:flutter/material.dart';
import 'package:single_child_scroll_view_study/constant/colors.dart';
import 'package:single_child_scroll_view_study/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  const SingleChildScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollView', body: renderPhysics(),);
  }

  //1. 기본 렌더링 법
  Widget renderSimple() {
    // 만약에 child 가 화면을 넘어가면 스크롤 가능하게 되고, 화면 안넘어가면 스크롤 안됌.
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  //2. 화면이 넘어가지 않아도 스크롤이 가능하게 하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // default : 스크롤이 안되게!
      // physics: NeverScrollableScrollPhysics(),
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  //3. 화면 위젯이 잘리지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  //4. 바운스 스타일
  Widget renderPhysics() {
    return SingleChildScrollView(
      // Android 스타일
      physics: ClampingScrollPhysics(),
      // IOS 스타일
      // physics: BouncingScrollPhysics(),
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
  }) {
    return Container(
      height: 300,
      color: color,
    );
  }
}
