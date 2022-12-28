import 'package:flutter/material.dart';
import 'package:single_child_scroll_view_study/constant/colors.dart';
import 'package:single_child_scroll_view_study/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({Key? key}) : super(key: key);

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListViewScreen',
      body: renderBuilder(),
    );
  }

  Widget renderBuilder() {
    // 화면에 벗어나면 랜더링을 하기 때문에 퍼포먼스적으로 좋다.
    // color 와 index 를 실제로 출력하는 numbers 를 참조하면, color 와 index 를 유지할 수 있다.
    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[numbers[index] % rainbowColors.length],
          index: numbers[index],
        );
      },
      itemCount: numbers.length,
      onReorder: (int oldIndex, int newIndex) {
        // onReorder : 순서를 바꾸면 onReorder 이 호출 된다.
        // oldIndex 순서를 바꾸기 전 index, newIndex 순서를 바꾼 후 index
        // oldIndex 와 newIndex 는 절대적으로 옮기기전 index 를 따른다.
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
    );
  }


  Widget renderDefault() {
    // 화면에서 순서를 바꿔주지만 실제 데이터에는 영향은 없다.
    // 전부다 랜더링 하기 때문에 퍼포먼스적으로 좋지 않다.
    return ReorderableListView(
      children: numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
      onReorder: (int oldIndex, int newIndex) {
        // onReorder : 순서를 바꾸면 onReorder 이 호출 된다.
        // oldIndex 순서를 바꾸기 전 index, newIndex 순서를 바꾼 후 index
        // oldIndex 와 newIndex 는 절대적으로 옮기기전 index 를 따른다.
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);

    return Container(
      // key 값을 넣어서 시스템적으로 다른 Container 라고 명시해준다.
      key: Key(index.toString()),
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
