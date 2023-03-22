import 'package:flutter/material.dart';
import 'package:portfolio/screen/components/app_bar.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/carina.jpeg",
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: CustomAppBar(),
            ),
            Spacer(),
            Body(),
            Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
}
