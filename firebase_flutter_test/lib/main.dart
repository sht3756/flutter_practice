import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter_test/pages/auth_page.dart';
import 'package:firebase_flutter_test/provider/page_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/my_home.dart';

void main() {
  runApp(const MyApp());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future: Firebase.initializeApp(),
    builder: (context, snapshot) {
      if(snapshot.hasError) {
        return Center(child: Text("문제가 있습니다. 다시시도해주세요."),);
      }
      if(snapshot.connectionState == ConnectionState.done) {
        return const MyApp();
      }
      return const CircularProgressIndicator();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
