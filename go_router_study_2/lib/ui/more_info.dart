import 'package:flutter/material.dart';
import 'package:go_router_study_2/login_state.dart';
import 'package:provider/provider.dart';

class MoreInfo extends StatefulWidget {
  const MoreInfo({Key? key}) : super(key: key);

  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'More Info',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Colors.black, width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      'Help Center',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Colors.black, width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      'Rate the App',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Colors.black, width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      'log out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      logOut(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logOut(BuildContext context) {
    Provider.of<LoginState>(context, listen: false).loggedIn = false;
  }
}
