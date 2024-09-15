import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_study/course_1/chat_bot/constants.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/chat_item_model.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/message_item_model.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/message_role_model.dart';
import 'package:flutter_native_study/course_1/chat_bot/page/chat_list_page/bloc/chat_list_bloc.dart';
import 'package:flutter_native_study/course_1/chat_bot/page/chat_list_page/chat_list_page.dart';
import 'package:flutter_native_study/course_1/chat_bot/page/chat_page/bloc/chat_messages_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatItemModelAdapter());
  Hive.registerAdapter(MessageItemModelAdapter());
  Hive.registerAdapter(MessageRoleModelAdapter());
  // runApp 전에 메모리에 적재해서 접근가능하게 선언
  await Hive.openBox<ChatItemModel>(kChatBox);
  await Hive.openBox<MessageItemModel>(kMessageBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatListBloc>(create: (context) => ChatListBloc()..add(const ChatListInitEvent())),
        BlocProvider<ChatMessagesBloc>(create: (context) => ChatMessagesBloc()),
      ],
      child: const MaterialApp(
        title: 'Flutter',
        home: ChatListPage(),
      ),
    );
  }
}
