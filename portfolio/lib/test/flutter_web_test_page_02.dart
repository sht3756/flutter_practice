import 'package:flutter/material.dart';
import 'package:portfolio/utils/size.dart';

class FlutterWebTestPage02 extends StatelessWidget {

  const FlutterWebTestPage02({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    isWeb = pageWidth > mobileWidth ? true : false;

    TextStyle h1 = const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
    );
    TextStyle h2 = const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
    );
    TextStyle h3 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 48,
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: pageWidth > breakPointWidth
                    ? (pageWidth - breakPointWidth) / 2 + 20
                    : 20,
                color: Colors.red,),
                Text("hizzang", style: isWeb ? h1 : h2),
                const Spacer(),
                Text("Hello", style: isWeb ? h2 : h3),
                const SizedBox(width: 24),
                Text("my", style: isWeb ? h2 : h3),
                const SizedBox(width: 24),
                Text("friend", style: isWeb ? h2 : h3),
                Container(
                  color: Colors.red,
                    width: pageWidth > breakPointWidth
                        ? (pageWidth - breakPointWidth) / 2 + 20
                        : 20),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('현재는 ${isWeb ? '웹 사이즈' : '모바일 사이즈'} ', style: const TextStyle(fontSize: 30),),
                Text("pageWidth: $pageWidth", style: const TextStyle(fontSize: 30),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
