import 'package:flutter/material.dart';

import 'circle_image.dart';

class FriendPostTitle extends StatelessWidget {
  const FriendPostTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const CircleImage(
            imageRadius: 24,
            imageProvider: AssetImage('assets/profile_pics/person_joe.jpeg'),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('text', style: Theme.of(context).textTheme.titleSmall),
              Text('text', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ))
        ],
      ),
    );
  }
}
