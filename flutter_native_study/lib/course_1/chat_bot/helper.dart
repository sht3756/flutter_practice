import 'package:flutter_native_study/course_1/chat_bot/api/model/completion.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/message_item_model.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/message_role_model.dart';

extension MessageItemListX on List<MessageItemModel> {
  CompletionRequest toCompletionRequest() {
    return CompletionRequest(
        'gpt-3.5-turbo',
        map((e) => MessageModel(
              e.role == MessageRoleModel.ai ? 'assistant' : 'user',
              e.message,
            ).toJson()).toList());
  }
}
