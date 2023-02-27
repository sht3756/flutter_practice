import 'package:firebase_flutter_test/provider/page_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AuthPage extends Page {
  static final pageName = "AuthPage";

  const AuthPage({super.key});

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return AuthWidget();
      },
    );
  }
}

class AuthWidget extends StatefulWidget {
  AuthWidget({super.key});

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final radiusSize = 8.0;
  bool isRegister = false;
  final _duration = Duration(milliseconds: 200);
  final _curve = Curves.fastOutSlowIn;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image.gif'),
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(
              //     Colors.black.withOpacity(.5), BlendMode.darken)
            )),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                reverse: true,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white54,
                    radius: 36,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        'assets/logo.png',
                        scale: 1.1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ButtonBar(
                    children: [_loginTabButton(context), _registerTabButton()],
                  ),
                  _textFormField(_emailController, 'Email Address'),
                  SizedBox(
                    height: 8,
                  ),
                  _textFormField(_passwordController, 'Password'),
                  AnimatedContainer(
                    duration: _duration,
                    height: isRegister ? 8 : 0,
                    curve: _curve,
                  ),
                  AnimatedContainer(
                      duration: _duration,
                      height: isRegister ? 60 : 0,
                      curve: _curve,
                      child: _textFormField(
                          _confirmController, 'Confirm Password')),
                  SizedBox(
                    height: 24,
                  ),
                  _loginButton(context),
                  Divider(
                    height: 50,
                    thickness: 1,
                    color: Colors.white54,
                    indent: 16,
                    endIndent: 16,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      _socialLogin(
                          assetLoction: 'assets/icons8-google-48.png',
                          onPress: () {
                            Provider.of<PageNotifier>(context, listen: false)
                                .goToMain();
                          }),
                      _socialLogin(
                          assetLoction: 'assets/icons8-facebook-48.png',
                          onPress: () {
                            Provider.of<PageNotifier>(context, listen: false)
                                .goToMain();
                          }),
                      _socialLogin(
                          assetLoction: 'assets/icons8-apple-logo-48.png',
                          onPress: () {
                            Provider.of<PageNotifier>(context, listen: false)
                                .goToMain();
                          }),
                    ],
                  )
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _socialLogin({required String assetLoction, required VoidCallback onPress}) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white54),
      child: IconButton(
          icon: ImageIcon(AssetImage(assetLoction)), onPressed: onPress),
    );
  }

  Widget _registerTabButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: isRegister ? Colors.black87 : Colors.black54,
      ),
      onPressed: () {
        setState(() {
          isRegister = true;
        });
      },
      child: Text('Register',
          style: TextStyle(
              fontSize: 18,
              fontWeight: isRegister ? FontWeight.w600 : FontWeight.w500, color: Colors.transparent)),
    );
  }

  Widget _loginTabButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: isRegister ? Colors.black54 : Colors.black87,
      ),
      onPressed: () {
        setState(() {
          isRegister = false;
        });
      },
      child: Text('Login',
          style: TextStyle(
              fontSize: 18,
              fontWeight: isRegister ? FontWeight.w500 : FontWeight.w600, color: Colors.transparent)),
    );
  }

  TextFormField _textFormField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      obscureText: controller != _emailController,
      style: TextStyle(color: Colors.white),
      validator: (text) {
        if (controller != _confirmController && (text == null || text.isEmpty))
          return "Please input something!!";

        if (controller == _confirmController && isRegister) {
          if ((text == null && text == '') ||
              text != _passwordController.text)
            return "Password you input does not match.";
        }

        return null;
      },
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        labelText: hint,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSize),
            borderSide: BorderSide(color: Colors.black, width: 3)),
        errorStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: Colors.black45,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSize),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSize),
            borderSide: BorderSide(color: Colors.transparent, width: 0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSize),
            borderSide: BorderSide(color: Colors.transparent, width: 0)),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (_formKey.currentState!.validate())
          Provider.of<PageNotifier>(context, listen: false).goToMain();
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSize)),
        padding: const EdgeInsets.all(16),
        foregroundColor: Colors.black87,
      ),

      child: Text(
        isRegister ? 'Register' : 'Login',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white54),
      ),
    );
  }
}