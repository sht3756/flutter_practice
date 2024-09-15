import 'package:json_annotation/json_annotation.dart';

part 'completion.g.dart';

@JsonSerializable()
class CompletionRequest {
  @JsonKey(name: 'model')
  final String model;
  @JsonKey(name: 'messages')
  final List<Map<String, dynamic>> messages;

  CompletionRequest(this.model, this.messages);

  factory CompletionRequest.fromJson(Map<String, dynamic> json) => _$CompletionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionRequestToJson(this);
}

@JsonSerializable()
class CompletionResponse {
  final String id;
  final int created;
  final String model;
  final List<ChoiceModel> choices;

  CompletionResponse(this.id, this.created, this.model, this.choices);

  factory CompletionResponse.fromJson(Map<String, dynamic> json) => _$CompletionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionResponseToJson(this);
}

@JsonSerializable()
class ChoiceModel {
  @JsonKey(name: 'index')
  final int index;
  @JsonKey(name: 'message')
  final MessageModel message;

  ChoiceModel(this.index, this.message);

  factory ChoiceModel.fromJson(Map<String, dynamic> json) => _$ChoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceModelToJson(this);
}

@JsonSerializable()
class MessageModel {
  @JsonKey(name: 'role')
  final String role;
  @JsonKey(name: 'content')
  final String content;

  MessageModel(this.role, this.content);

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}