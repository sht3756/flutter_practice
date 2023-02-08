import 'package:flutter/material.dart';
import 'package:note_app/di/provider_setupe.dart';
import 'package:note_app/presentation/notes/note_screen.dart';
import 'package:note_app/ui/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  // 플랫폼 채널의 위젯 바인딩을 보장한다.(getProviders 에서 디비를 연결할때 native 코드를 사용할텐데, 그 코드가 연결이 다 된후 실행하기 위함.)
  WidgetsFlutterBinding.ensureInitialized();
  // 프로바이더 가져와서
  final providers = await getProviders();

  // MultiProvider 로 한번에 넣어주기!
  runApp(
    MultiProvider(
        providers: providers,
        child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.white,
          backgroundColor: darkGray,
          canvasColor: darkGray,
          floatingActionButtonTheme: Theme
              .of(context)
              .floatingActionButtonTheme
              .copyWith(
            backgroundColor: Colors.white,
            foregroundColor: darkGray,
          ),
          appBarTheme: Theme
              .of(context)
              .appBarTheme
              .copyWith(
            backgroundColor: darkGray,
          )
      ),
      home: const NoteScreen(),
    );
  }
}
