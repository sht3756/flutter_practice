import 'package:flutter_native_study/course_1/chat_bot/hive_model/message_role_model.dart';
import 'package:hive/hive.dart';

part 'message_item_model.g.dart';

@HiveType(typeId: 1)
class MessageItemModel {
  @HiveField(0)
  final String message;
  @HiveField(1)
  final MessageRoleModel role;
  @HiveField(2)
  final DateTime createdAt;

  MessageItemModel(this.message, this.role, this.createdAt);
}