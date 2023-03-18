import 'package:flutter/material.dart';
import 'package:portfolio/screen/home_screen.dart';
import 'package:portfolio/utils/size.dart';

class DefaultLayout extends StatelessWidget {
  final AppBar appBar;

  const DefaultLayout({Key? key, required this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    isWeb = pageWidth > mobileWidth ? true : false;
    bool isDarkMode = false;

    return Scaffold(
      body: Column(
        children: [
          _Header(isWeb: isWeb, isDarkMode: isDarkMode),
          _Body(isWeb: isWeb, isDarkMode: isDarkMode),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool isWeb;
  final bool isDarkMode;

  const _Header({Key? key, required this.isDarkMode, required this.isWeb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle isWebHeaderTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
    TextStyle isBodyTextStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
    TextStyle isMobileTextStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );

    return Container(
      width: double.infinity,
      height: 48,
      color: Colors.black54,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: pageWidth > breakPointWidth
              ? (pageWidth - breakPointWidth) / 2 + 10
              : 20,
        ),
        Text("<Shin Heetae/>",
            style: isWeb ? isWebHeaderTextStyle : isBodyTextStyle),
        if (isWeb) const Spacer(),
        if (isWeb)
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext) => HomeScreen()));
              },
              child: Text("Home",
                  style: isWeb ? isBodyTextStyle : isMobileTextStyle)),
        if (isWeb) const SizedBox(width: 24),
        if (isWeb)
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext) => HomeScreen()));
              },
              child: Text("About",
                  style: isWeb ? isBodyTextStyle : isMobileTextStyle)),
        if (isWeb) const SizedBox(width: 24),
        if (isWeb)
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext) => HomeScreen()));
              },
              child: Text("Career",
                  style: isWeb ? isBodyTextStyle : isMobileTextStyle)),
        if (isWeb) const SizedBox(width: 24),
        if (isWeb)
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext) => HomeScreen()));
              },
              child: Text("Projects",
                  style: isWeb ? isBodyTextStyle : isMobileTextStyle)),
        if (isWeb) const SizedBox(width: 24),
        if (isWeb)
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext) => HomeScreen()));
              },
              child: Text("Blog",
                  style: isWeb ? isBodyTextStyle : isMobileTextStyle)),
        if (isWeb) const SizedBox(width: 24),
        IconButton(
            onPressed: () {},
            icon: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
            )),
        SizedBox(
            width: pageWidth > breakPointWidth
                ? (pageWidth - breakPointWidth) / 2
                : 20),
      ]),
    );
  }
}

class _Body extends StatelessWidget {
  final bool isWeb;
  final bool isDarkMode;

  const _Body({Key? key, required this.isDarkMode, required this.isWeb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.star,
        children: [
          Text(
            '현재는 ${isWeb ? '웹 사이즈' : '모바일 사이즈'} ',
            style: const TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
