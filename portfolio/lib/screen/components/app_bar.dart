import 'package:flutter/material.dart';

import 'menu_item.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = '<Shin Heetae />';
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 30,
            color: Colors.black.withOpacity(0.16),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.handshake_sharp),
          Text(name),
          const Spacer(),
          MenuItem(title: 'about',onTap: (){},),
          MenuItem(title: 'blog',onTap: (){},),
          MenuItem(title: 'career',onTap: (){},),
          MenuItem(title: 'project',onTap: (){},),

        ],
      ),
    );
  }
}

