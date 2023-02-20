import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_by_thecodingpapa/pages/auth_page.dart';
import 'package:template_by_thecodingpapa/pages/my_home.dart';
import 'package:template_by_thecodingpapa/provider/page_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PageNotifier())],
      child: MaterialApp(
        home: Consumer<PageNotifier>(
          builder: (context, pageNotifier, child) {
            return Navigator(
              pages: [
                MaterialPage(
                    key: ValueKey(MyHome.pageName),
                    child: MyHome(
                        title: 'Flutter Demo Home Page')), // main home page

                if (pageNotifier.curPage == AuthPage.pageName) AuthPage()
              ],
              onPopPage: (route, result) {
                if (!route.didPop(result)) {
                  return false;
                }

                pageNotifier.goToMain();
                return true;
              },
            );
          },
        ),
      ),
    );
  }
}
