import 'package:flutter/material.dart';

import '../models/models.dart';
import 'circle_image.dart';

class FriendPostTitle extends StatelessWidget {
  final Post post;

  const FriendPostTitle({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleImage(
          imageRadius: 20,
          imageProvider: AssetImage(post.profileImageUrl),
        ),
        const SizedBox(width: 16),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.comment, style: Theme.of(context).textTheme.titleSmall),
            Text('${post.timestamp} minutes ago',
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ))
      ],
    );
  }
}
