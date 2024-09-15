import 'package:flutter/material.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/chat_item_model.dart';

class ChatItem extends StatelessWidget {
  final ChatItemModel item;
  final VoidCallback onTapped;
  final VoidCallback onDelete;

  const ChatItem({
    super.key,
    required this.item,
    required this.onTapped,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(item.title),
        onTap: onTapped,
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      );
}
