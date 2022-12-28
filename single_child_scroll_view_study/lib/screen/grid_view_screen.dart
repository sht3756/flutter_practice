import 'package:flutter/material.dart';
import 'package:single_child_scroll_view_study/constant/colors.dart';
import 'package:single_child_scroll_view_study/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  GridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'GridViewScreen',
      body: renderBuilderCrossAxis(),
    );
  }

  // 1. 한번에 다 그림, 효율성 떨어짐
  Widget renderCount() {
    return GridView.count(
      // 주체: 가로, 가로 최대 몇개 배치
      crossAxisCount: 2,
      // 가로 간경
      crossAxisSpacing: 12.0,
      // 세로 간격
      mainAxisSpacing: 12.0,
      children: numbers
          .map((e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length], index: e))
          .toList(),
    );
  }

  //2. 보이는 것만 보임 (그래서 효율성 좋다.)
  Widget renderBuilderCrossAxisCount() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 가로에 최대 몇개 배치
        crossAxisCount: 2,
        // 가로 여백 사이즈
        crossAxisSpacing: 12.0,
        // 세로 여백 사이즈
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index);
      },
    );
  }

  // 3. 2번 과 같다. 위젯 최대 길이에 따라서 그림
  Widget renderBuilderCrossAxis() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        // 위젯들의 최대 길이
        maxCrossAxisExtent: 200,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index);
      },
      // item 총 개수 정할 수 있다.(없으면 무한대!)
      itemCount: 100,
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);

    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
