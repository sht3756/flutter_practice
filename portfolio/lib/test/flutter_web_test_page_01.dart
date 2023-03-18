import 'package:flutter/material.dart';
import 'package:portfolio/utils/size.dart';
import 'package:portfolio/test/flutter_web_test_page_02.dart';

class FlutterQueryTest extends StatelessWidget {
  const FlutterQueryTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width;
    double fixedMediaQueryData = fixedWidth;
    double flexibleMediaQueryData =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    double devicePhysicalSize =
        WidgetsBinding.instance.window.physicalSize.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 48,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.primary,
            child: const Text(
              "Page 01",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("MediaQuery: $mediaQuery"),
                Text("Fixed MediaQueryData: $fixedMediaQueryData"),
                Text("Flexible MediaQueryData : $flexibleMediaQueryData"),
                Text("DevicePhysicalWidth: $devicePhysicalSize"),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => FlutterWebTestPage02(),
                ),
              );
            },
            child: const Text('2 페이지로'),
          ),
        ],
      ),
    );
  }
}
