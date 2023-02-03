// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'photo_model.g.dart';
//
// @JsonSerializable()
// class PhotoModel extends Equatable {
//   final int id;
//   final String tags;
//
//   // 리네임 가능하다.
//   @JsonKey(name: 'previewURL')
//   final String previewUrl;
//
//   const PhotoModel({
//     required this.id,
//     required this.tags,
//     required this.previewUrl,
//   });
//
//   factory PhotoModel.fromJson(Map<String, dynamic> json)
//   => _$PhotoModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
//
//   @override
//   List<Object?> get props => [id];
// }

// 위에는 JsonSerializable 로 작성한 코드,
// 아래는 Freezed 로 작성한 코드

import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class PhotoModel with _$PhotoModel {
  factory PhotoModel({
    required int id,
    required String tags,
    required String previewURL,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, dynamic> json)
  => _$PhotoModelFromJson(json);
}