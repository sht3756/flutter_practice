import 'package:chat_app/constants/firestore_constants.dart';
import 'package:chat_app/models/user_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateException,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;

  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.prefs,
    required this.firebaseFirestore,
  });

  // 파이어베이스 아이디 가져오기(String)
  String? getUserFirebaseId() {
    return prefs.getString(FirestoreConstants.id);
  }

  // 로그인 확인 (bool)
  Future<bool> isLoggedIn() async {
    // googleSignIn 에서 현재 로그인했는지 여부
    bool isLoggedIn = await googleSignIn.isSignedIn();

    // 현재 로그인 여부 && prefs에 저장한 id 값이 빈값이 아니라면!
    if (isLoggedIn &&
        prefs.getString(FirestoreConstants.id)?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

  // 회원가입
  Future<bool> handleSignIn() async {
    _status = Status.authenticating;
    notifyListeners();

    // 구글 로그인, 로그인한 유저의 정보가 들어있다.
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // 구글 로그인 성공, 유저 정보 있으면?
    if (googleUser != null) {
      // 구글 유저 인증
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      // 파이어베이스의 필요한 credential 을 만들어준다.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 파이어베이스 유저
      User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      // 유저의 정보가 담겨있다면?
      if (firebaseUser != null) {
        // 파이어베이스 스토어에서 지정된 경로, id 와 파이어베이스 유저의 uid 가 같은걸 가져와라
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
            .get();

        // 파이어베이스 스토어에 포함되어있는 데이터를 읽은 문서이다.
        final List<DocumentSnapshot> documents = result.docs;

        // 데이터가 없다면?
        if (documents.length == 0) {
          // 파이어베이스 스토어에 새 유저 정보 넣기
          firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .doc(firebaseUser.uid)
              .set({
            FirestoreConstants.nickname: firebaseUser.displayName,
            FirestoreConstants.photoUrl: firebaseUser.photoURL,
            FirestoreConstants.id: firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreConstants.chattingWith: null
          });
          // 로컬 스토리지에 데이터 넣기
          User? currentUser = firebaseUser;
          await prefs.setString(FirestoreConstants.id, currentUser.uid);
          await prefs.setString(
              FirestoreConstants.nickname, currentUser.displayName ?? "");
          await prefs.setString(
              FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
        } else {
          // 데이터가있다면?
          // 이미 회원가입 되었고, 파이어베이스 스토어에서 데이터 가져온다.
          DocumentSnapshot documentSnapshot = documents[0];
          // 파이어스토어에서 가져와 UserChat 인스턴스화 시킨다.
          UserChat userChat = UserChat.fromDocument(documentSnapshot);
          // 로컬 스토리지에 데이터 넣기
          await prefs.setString(FirestoreConstants.id, userChat.id);
          await prefs.setString(FirestoreConstants.nickname, userChat.nickname);
          await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
          await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
        }
        _status = Status.authenticated;
        notifyListeners();
        return true;
      } else {
        // 파이어베이스 스토어에 유저가 없다면?
        _status = Status.authenticateError;
        notifyListeners();
        return false;
      }
    } else {
      // 구글 로그인 실패, 유저 없음
      _status = Status.authenticateCanceled;
      notifyListeners();
      return false;
    }
  }

  // 예외처리 함수
  void handleException() {
    _status = Status.authenticateException;
    notifyListeners();
  }

  // 로그아웃 함수
  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }
}
