import 'package:flutter/material.dart';
import 'package:go_router_study_2/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_holder.dart';
import 'package:provider/provider.dart';

import 'login_state.dart';
import 'ui/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = LoginState(await SharedPreferences.getInstance());
  state.checkLoggedIn();
  runApp(MyApp(loginState: state));
}

class MyApp extends StatelessWidget {
  final LoginState loginState;

  const MyApp({Key? key, required this.loginState}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartHolder>(
          lazy: false,
          create: (_) => CartHolder(),
        ),
        ChangeNotifierProvider<LoginState>(
          lazy: false,
          create: (BuildContext createContext) => loginState,
        ),
        Provider<MyRouter>(
          lazy: false,
          create: (context) => MyRouter(loginState),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          // Provider 를 통해서 MyRouter 에서 등록한 GoRouter 를 가져온다.
          final router = Provider.of<MyRouter>(context, listen: false).router;

          return MaterialApp.router(
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            title: 'Navigator',
            theme: ThemeData(primarySwatch: Colors.cyan),
          );
        },
      ),
    );
  }
}
