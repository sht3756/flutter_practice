import 'package:flutter/material.dart';
import 'package:single_child_scroll_view_study/constant/colors.dart';
import 'package:single_child_scroll_view_study/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ListViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderSeparated(),
    );
  }

  // 기본: 모두 한번에 그린다.
  Widget renderDefault() {
    return ListView(
      children: numbers
          .map((e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ))
          .toList(),
    );
  }

// 2. 보이는것만 그림
  Widget renderBuilder() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

// 3. 2+ 중간 중간마다 추가로 위젯을 넣을 수 있다.
  Widget renderSeparated() {
    return ListView.separated(
        itemCount: 100,
        itemBuilder: (context, index) {
          return renderContainer(
              color: rainbowColors[index % rainbowColors.length], index: index);
        },
        separatorBuilder: (context, index) {
          index += 1;

          // 5개의 item마다 배너 보여주기
          if (index % 5 == 0) {
            return renderContainer(
              color: Colors.black,
              index: index,
              height: 100,
            );
          }
          return SizedBox(
            height: 32.0,
          );
        });
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
