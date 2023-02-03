import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel extends Equatable{
  final int id;
  final String tags;

  // 리네임 가능하다.
  @JsonKey(name: 'previewURL')
  final String previewUrl;
  
  const PhotoModel({
    required this.id,
    required this.tags,
    required this.previewUrl,
});
  factory PhotoModel.fromJson(Map<String, dynamic> json)
  => _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);

  @override
  List<Object?> get props => [id];
}