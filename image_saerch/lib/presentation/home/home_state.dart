import 'package:image_saerch/domain/model/photo_model.dart';

// photos 와 isLoading 의 상태를 관리하는 클래스
// class HomeState {
//   final List<PhotoModel> photos;
//   final bool isLoading;
//
//   HomeState(this.photos, this.isLoading);
//
//   // 외부에서는 state 변화 안되게 만들었으니, copyWith 으로 변경 가능하게!
//   HomeState copyWith({List<PhotoModel>? photos, bool? isLoading}) {
//     return HomeState(
//       photos ??= this.photos,
//       isLoading ??= this.isLoading,
//     );
//   }
// }

// 만약에 파라미터가 많아지면, 코드가 길어지는데, freezed 를 사용하면 더욱더 간편하게 만들수 있다.
// 자동으로 copyWith() 함수가 있다.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState(
    List<PhotoModel> photos,
    bool isLoading,
  ) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
