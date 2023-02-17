import 'package:flutter/material.dart';

import 'circle_image.dart';

class AuthorCard extends StatefulWidget {
  const AuthorCard({
    Key? key,
    required this.authorName,
    required this.title,
    required this.imageProvider,
  }) : super(key: key);

  final String authorName;
  final String title;
  final ImageProvider imageProvider;

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool iconClicked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleImage(imageProvider: widget.imageProvider),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.authorName,
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            )
          ],
        ),
        IconButton(
          icon: Icon(iconClicked ? Icons.favorite : Icons.favorite_border),
          onPressed: () {
            iconClicked = !iconClicked;
            setState(() {});

            const snackBar = SnackBar(content: Text('Favorite clicked'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      ],
    );
  }
}
