import 'package:flutter/material.dart';
import 'package:single_child_scroll_view_study/constant/colors.dart';

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // list 형태의 위젯들을 한번에 쓸수 있게끔 해준다! 하지만 특정 되어있다.
        slivers: [
          // ios : appBar 가 스크롤이 된다.
          SliverAppBar(
            title: Text('CustomScrollViewScreen'),
          ),
          renderBuilderSliverList(),
        ],
      ),
    );
  }

  // ListView 기본 생성자와 유사함
  SliverList renderChildSliverList() {
    return SliverList(
      // delegate : 어떤 형태로 SliverList 를 만들어낼지 정할 수 있다.(전부다 랜더링 or .builder() 로 조금씩 랜더링 하냐)
      // appbar 같이 스크롤 되어서 사라진다.
      // 모든 리스트가 한번에 랜더링 된다.
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length], index: e),
            )
            .toList(),
      ),
    );
  }

  // ListView.builder 생성자와 유사함
  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        // 숫자 제한
        childCount: 100,
      ),
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
