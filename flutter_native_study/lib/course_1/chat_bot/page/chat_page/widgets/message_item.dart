import 'package:flutter/material.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/message_item_model.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/message_role_model.dart';
import 'package:flutter_native_study/course_1/chat_bot/utils/chat_date_utils.dart';

class MessageItem extends StatelessWidget {
  final MessageItemModel item;

  const MessageItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isUser = item.role == MessageRoleModel.user;
    final String formattedTime = ChatDateUtils.formatDate(item.createdAt);
    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                formattedTime,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4.0),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: isUser? Colors.blue[200] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(item.message),
              )
            ],
          ),
        ))
      ],
    );
  }
}
