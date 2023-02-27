import 'package:email_auth/provider/page_notifier.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class CheckYourEmail extends Page {
  static const pageName = "CheckYourEmail";

  const CheckYourEmail({super.key});

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return const CheckYourEmailWidget();
      },
    );
  }
}

class CheckYourEmailWidget extends StatefulWidget {
  const CheckYourEmailWidget({super.key});

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<CheckYourEmailWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image.gif'),
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(
              //     Colors.black.withOpacity(.5), BlendMode.darken)
            )),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [_sendVerification(), _signOut(), _emailVerified(context)],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sendVerification() {
    return TextButton(
      onPressed: () async {
        FirebaseAuth.instance.currentUser?.sendEmailVerification();
        SnackBar snackBar = const SnackBar(content: Text('보내준 이메일 안에 링크로 이메일 확인 부탁드려요.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.white54,
      ),
      child: const Text(
        "Send email Verification to User email",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }

  Widget _signOut() {
    return TextButton(
      onPressed: () async {
        FirebaseAuth.instance.signOut();
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.white54,
      ),
      child: const Text(
        "User other account. Sign out!",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }

  Widget _emailVerified(BuildContext context) {
    return TextButton(
      onPressed: () async {
        Provider.of<PageNotifier>(context, listen: false).refresh();
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.white54,
      ),
      child: const Text(
        "email Verified!! try to go to main page",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }
}