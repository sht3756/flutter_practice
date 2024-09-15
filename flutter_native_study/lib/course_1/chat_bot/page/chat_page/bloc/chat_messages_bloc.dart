import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_study/course_1/chat_bot/constants.dart';
import 'package:flutter_native_study/course_1/chat_bot/helper.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/chat_item_model.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/message_item_model.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/message_role_model.dart';
import 'package:loggy/loggy.dart';
import '../../../api/model/api_service.dart';

part 'chat_messages_event.dart';

part 'chat_messages_state.dart';

class ChatMessagesBloc extends Bloc<ChatMessagesEvent, ChatMessagesState> {
  ChatMessagesBloc() : super(ChatMessagesLoadingState()) {
    on<ChatMessagesInitialEvent>(_onChatMessageInit);
    on<ChatMessagesAddEvent>(_addMessages);
  }

  final _apiService = ApiService(
    Dio()
      ..interceptors.addAll([
        LoggyDioInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          responseLevel: LogLevel.all,
          requestLevel: LogLevel.all,
          errorLevel: LogLevel.all,
        )
      ])
      ..options.headers['Authorization'] = kApiKey,
  );

  void _onChatMessageInit(
      ChatMessagesInitialEvent event, Emitter<ChatMessagesState> emit) {
    final chatItem = event.chatItem;
    final messages = chatItem.messages;

    emit(state.copyWith(
      chatItem: chatItem,
      messages: messages,
    ));
  }

  void _addMessages(
      ChatMessagesAddEvent event, Emitter<ChatMessagesState> emit) async {
    final message = event.message;
    final newMessage =
        MessageItemModel(message, MessageRoleModel.user, DateTime.now());

    state.chatItem?.messages.add(newMessage);
    state.chatItem?.save();

    // 사용자가 채팅을 입력 후, API 로 부터 응답을 기다리는 상황
    emit(state.copyWith(messages: state.messages, isLoading: true));

    final response =
        await _apiService.getCompletion(state.messages.toCompletionRequest());

    final completion = response.choices.first.message.content;
    final newAiMessage =
        MessageItemModel(completion, MessageRoleModel.ai, DateTime.now());
    state.chatItem?.messages.add(newAiMessage);
    state.chatItem?.save();
    emit(state.copyWith(messages: state.messages, isLoading: false));
  }
}
