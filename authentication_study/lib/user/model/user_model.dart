import 'package:authentication_study/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

// 상태가 에러일때는 UserModelError 클래스
class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

// 상태가 로딩일때는 UserModelLoading 클래스
class UserModelLoading extends UserModelBase {}

// 상태가 성공적일때는 UserModel 클래스
@JsonSerializable()
class UserModel extends UserModelBase {
  final String id;
  final String username;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imageUrl;

  UserModel({
    required this.id,
    required this.username,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
