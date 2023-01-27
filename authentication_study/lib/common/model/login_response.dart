// 응답 받을 수 있는 형태를 JsonSeriable 형태로 제작하겠다.
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String refreshToken;
  final String accessToken;

  LoginResponse({
    required this.refreshToken,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginreponseFromJson(json);
}
