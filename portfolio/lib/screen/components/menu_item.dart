import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const MenuItem({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(title),
      ),
    );
  }
}
