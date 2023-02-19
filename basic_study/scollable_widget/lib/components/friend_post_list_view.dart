import 'package:flutter/material.dart';

import 'components.dart';

class FriendPostListView extends StatelessWidget {
  const FriendPostListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Social Chefs'),
        ListView.separated(
          // ListView 는 스크롤을 안하겠다.
          primary: false,
          // 아이템 높이만큼만 ListView 사이즈를 조정해줘
          shrinkWrap: true,
          // 스크롤 기능 꺼버리는 위젯
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return FriendPostTitle();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 16.0,
            );
          },
          itemCount: 10,
        ),
      ],
    );
  }
}
