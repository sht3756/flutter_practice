import 'package:firebase_flutter_test/pages/auth_page.dart';
import 'package:flutter/cupertino.dart';

class PageNotifier extends ChangeNotifier {
  String? _currentPage = AuthPage.pageName;

  String? get curPage => _currentPage;

  void goToMain() {
    _currentPage = null;
    notifyListeners();
  }

  void showPage(String page) {
    _currentPage = page;
    notifyListeners();
  }
}