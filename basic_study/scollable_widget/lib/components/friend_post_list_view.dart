import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> posts;

  const FriendPostListView({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Chefs',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 16.0),
          ListView.separated(
            // ListView 는 스크롤을 안하겠다.
            primary: false,
            // 아이템 높이만큼만 ListView 사이즈를 조정해줘
            shrinkWrap: true,
            // 스크롤 기능 꺼버리는 위젯
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return FriendPostTitle(post: posts[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16.0,
              );
            },
            itemCount: posts.length,
          ),
        ],
      ),
    );
  }
}
