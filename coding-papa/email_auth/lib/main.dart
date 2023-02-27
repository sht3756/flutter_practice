import 'package:email_auth/pages/check_your_email.dart';
import 'package:email_auth/pages/my_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:email_auth/pages/auth_page.dart';
import 'package:email_auth/provider/page_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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

                if (pageNotifier.curPage == AuthPage.pageName) const AuthPage(),
                if (pageNotifier.curPage == CheckYourEmail.pageName) const CheckYourEmail(),
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
