import 'package:flutter/material.dart';
import 'package:hello_world_first/navigation_study/layout/main_layout.dart';
import 'package:hello_world_first/navigation_study/screen/route_one_screen.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home Screen',
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => RouterOneScreen()));
          },
          child: Text('Push'),
        ),
      ],
    );
  }
}
