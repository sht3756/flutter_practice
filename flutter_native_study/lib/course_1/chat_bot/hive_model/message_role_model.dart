import 'package:hive/hive.dart';

part 'message_role_model.g.dart';

@HiveType(typeId: 2)
enum MessageRoleModel {
  @HiveField(0)
  ai,
  @HiveField(1)
  user,
}