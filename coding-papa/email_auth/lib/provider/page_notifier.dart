import 'package:email_auth/pages/auth_page.dart';
import 'package:email_auth/pages/check_your_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PageNotifier extends ChangeNotifier {
  String? _currentPage = AuthPage.pageName;

  String? get curPage => _currentPage;

  PageNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        // 비로그인일때
        showPage(AuthPage.pageName); // 로그인 페이지
      }
      if (user != null) {
        // 로그인된 상태일때
        if (user.emailVerified) {
          goToMain(); // 메인페이지
        } else {
          showPage(CheckYourEmail.pageName);
        }
      }
    });
  }

  void goToMain() {
    _currentPage = null;
    notifyListeners();
  }

  void showPage(String page) {
    _currentPage = page;
    notifyListeners();
  }

  void refresh() async {
    FirebaseAuth.instance.currentUser?.reload();

    User user = FirebaseAuth.instance.currentUser!;
    print('user data : ${user.toString()}');

    if (user == null) showPage(AuthPage.pageName);

    if (user.emailVerified) {
      goToMain();
    } else {
      showPage(CheckYourEmail.pageName);
    }
  }
}
