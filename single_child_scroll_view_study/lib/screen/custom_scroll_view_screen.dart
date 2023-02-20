import 'package:flutter/material.dart';
import 'package:single_child_scroll_view_study/constant/colors.dart';

// SliverPersistentHeaderDelegate 를 상속 해야한다.
// @override 를 4개를 꼭 해줘야한다.
class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // 최대 높이
  double get maxExtent => maxHeight;

  @override
  // 최소 높이
  double get minExtent => minHeight;

  @override
  //covariant : 상속된 클래스도 사용가능, 이거를(SliverPersistentHeaderDelegate) 상속한 클래스 일수 도있다는 것을 명시해주는것이다.
  // 편의상 바꿔준다. 현재 상황에서는 이미 _SliverFixedHeaderDelegate에서 상속을 했으니 다른걸 상속했을 경우는 없다.
  // oldDelegate 는 오래된 것을 의미한거다. build 가 될 때 이전인 기존에 존재하던 delegate
  // thisDelegate 는 새로운 delegate 이다.
  // shouldRebuild - 새로 build 를 해야할지 말지 결정해주는 함수
  // false : build 안함, true : build 다시함
  // 그러니 특정 조건을 넣어주면 됌. child 값이 바뀌거나 minHeight, maxHeight 가 바뀔때 해주면 됌
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minHeight ||
        oldDelegate.maxExtent != maxHeight;
  }
}

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
          // renderSliverAppBar(),
          renderHeader(),
          renderChildSliverGrid(),
          renderHeader(),
          renderSliverGridBuilder(),
          renderHeader(),
          renderBuilderSliverList(),
        ],
      ),
    );
  }

  // Header
  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      // 헤더에 쌓인다.
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.pink,
          child: Center(
            child: Text(
              '내용',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        minHeight: 200,
        maxHeight: 250,
      ),
    );
  }

  // AppBar
  SliverAppBar renderSliverAppBar() {
    return SliverAppBar(
      // 리스트의 중간에서 위로 당기면 AppBar 가 나오게 설정
      floating: true,
      // 완전 고정, 기본 AppBar 설정이다.
      pinned: false,
      // true: 중간에 멈출 수 있다. false: 중간이 없이 올라가거나 내려간다. 단, floating: true 일때만 사용가능
      snap: false,
      // true: 맨위에서 스크롤 했을때 남는 공간을 차지한다. 단, physics : BouncingPhysics 를 썼을때만 사용가능
      stretch: true,
      // 최대 사이즈 설정
      expandedHeight: 200,
      // 최소 사이즈 설정
      collapsedHeight: 150,
      // AppBar 공간을 차지하는 부분 설정, 앱바의 전체 부분을 차지한다.
      // flexibleSpace: FlexibleSpaceBar(
      //   background: Image.asset(
      //     'asset/img/image_1.jpeg',
      //     fit: BoxFit.cover,
      //   ),
      //   title: Text('FlexibleSpaceBar'),
      // ),
      title: Text('CustomScrollViewScreen'),
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
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
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

  // GridView.count 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  // GridView.builder 와 비슷함
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
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
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // 가로 최대 넓이
          maxCrossAxisExtent: 150,
        ));
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
